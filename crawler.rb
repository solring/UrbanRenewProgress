# -*- coding: utf-8 -*-
require 'rubygems'
require 'httpclient'
require 'nokogiri'
require 'json'

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


def getArguments2(content, form)
    
    doc = Nokogiri::HTML(content)
    viewstate = ""
    evalidate = ""
    vs = doc.css("##{form} #__VIEWSTATE")
    ev = doc.css("##{form} #__EVENTVALIDATION")
    if vs.length >= 1
        viewstate = vs[0]["value"]
    end
    if ev.length >= 1
        evalidate = ev[0]["value"]
    end
    return viewstate, evalidate
end

def filterMsg(content)
    doc = Nokogiri::HTML(content)
	
    msg = ""
	msg_tag = doc.css("#labMsg")
	if msg_tag.length > 0
		msg = msg_tag.text
	end
	
	table = doc.at_css("#grdQuery")

	if table.length < 1
        #return "ERROR: span labMsg does not exist"
		return "ERROR: table grdQuery does not exist"
    else
		rows = table.xpath('//tbody//tr')
		if rows.length >= 2
		
			cols = rows[1].xpath('//td')
			
			query = cols[0].text
			id = cols[1].text
			name = cols[2].text
			status = cols[3].text
			detail = cols[4].at_xpath("//p//a").attr('href')
			
			data = {
				:query => query,
				:id => id,
				:name => name,
				:status => status,
				:msg => msg
			}
			return data.to_json
		else
			return "ERROR: table empty"
		end
    end

end

def getURProgress(sec, num_major, num_minor)

    puts "#{sec}, #{num_major}, #{num_minor}"

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
        'txtMono' => num_major,
        'txtSbno' => num_minor
    }

# the first GET to get website content
    res = client.get(uri1)

    content = res.content
    
    #viewstate, evalidate = getArguments(content)
    viewstate, evalidate = getArguments2(content, "aspnetForm")
    
    puts '--------------- POST 1 ------------------'

    body1['__VIEWSTATE'] = viewstate
    body1['__EVENTVALIDATION'] = evalidate

    res = client.post(uri1, body1)

    puts '--------------- GET 2 --------------------'
    res = client.get('http://163.29.37.171/planMap/showland_uro.aspx', header)
    content = res.content

    puts '--------------- POST 2 ------------------'
    #viewstate, evalidate = getArguments(content)
    viewstate, evalidate = getArguments2(content, "Form1")

    body2['__VIEWSTATE'] = viewstate
    body2['__EVENTVALIDATION'] = evalidate

    res = client.post(uri2, body2)
    #puts res.content
    return filterMsg(res.content)
end

#puts getURProgress('永昌段一小段', '0031', '0004')



