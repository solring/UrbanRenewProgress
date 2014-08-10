# -*- coding: utf-8 -*-
require 'rubygems'
require 'httpclient'
#require 'mechanize'

def getArguments(content)
    re_viewstate = /id="__VIEWSTATE" value="(.*?)"/
    re_eventvalidation = /id="__EVENTVALIDATION" value="(.*?)"/
    viewstate = ""
    evalidate = ""
    
    matches = re_viewstate.match(content)
    if matches != nil
        viewstate = matches[1]
    end

    matches = re_eventvalidation.match(content)
    if matches != nil 
        evalidate = matches[1]
    end

    return viewstate, evalidate
end

def filterMsg(content)
    reg = /<span id="labMsg" .*?>(.*?)<\/font><\/span>"/
    msg = ""
    matches = reg.match(content)
    if matches != nil
        msg = matches[1]
    end
    return msg
end

def getURProgress(dist, sec, num_major, num_minor)
    
    uri1 = 'http://www.gis.udd.taipei.gov.tw/r_progress.aspx'
    uri2 = "http://163.29.37.171/planMap/showland_uro.aspx"
    client = HTTPClient.new


    header = {
        'Referer' => uri1,
        'Host' => "http://163.29.37.171",
        'Connection' => "keep-alive"
    }
    
    body1 = {
        'ctl00$ContentPlaceHolder1$ScriptManager1' => 'ctl00$ContentPlaceHolder1$UpdatePanel1|ctl00$ContentPlaceHolder1$RadioButtonList1$0',
        '__EVENTTARGET' => 'ctl00$ContentPlaceHolder1$RadioButtonList1$0',
        '__EVENTARGUMENT' => '',
        '__LASTFOCUS' => '',
        '__VIEWSTATE' => '',
        '__EVENTVALIDATION' => '',
        
        'ctl00$txtUserId' => '',
        'ctl00$txtUserPwd' => '',
        'ctl00$ContentPlaceHolder1$RadioButtonList1' => 'http://163.29.37.171/planMap/showland_uro.aspx'
    }

    body2 = {
        '__EVENTTARGET' => '',
        '__EVENTARGUMENT' => '',
        '__LASTFOCUS' => '',
        '__VIEWSTATE' => '',
        '__EVENTVALIDATION' => '',
        'imgSearch.x' => 29,
        'imgSearch.y' => 26,
        'txtSect' => sec,
        #'optArea' => dist,
        #'optSect' => sec,
        #'radKind' => "radKind2",
        'radKind' => "radKind1",
        'txtMono1' => num_major,
        'txtSbno1' => num_minor
    }

# the first GET to get website content
    res = client.get(uri1)

    content = res.content
    
    viewstate, evalidate = getArguments(content)
    
    #puts '--------------- POST 1 ------------------'

    body1['__VIEWSTATE'] = viewstate
    body1['__EVENTVALIDATION'] = evalidate

    res = client.post(uri1, body1)

    #puts '--------------- GET 2 --------------------'
    res = client.get('http://163.29.37.171/planMap/showland_uro.aspx', header)
    content = res.content
    
    #puts '--------------- POST 2 ------------------'
    viewstate, evalidate = getArguments(content)

    body2['__VIEWSTATE'] = viewstate
    body2['__EVENTVALIDATION'] = evalidate

    res = client.post(uri2, body2)
    content = res.content.sub("\n", "")
    puts content
    #puts "status: #{res.status}"
    return filterMsg(content)
end

puts getURProgress('中正區', '永昌段一小段', '0031', '0004')



