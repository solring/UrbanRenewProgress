# -*- coding: utf-8 -*-
require 'rubygems'
require 'mechanize'

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

def getURProgress(dist, sec, num_major, num_minor)
    
    uri1 = 'http://www.gis.udd.taipei.gov.tw/r_progress.aspx'
    uri2 = "http://163.29.37.171/planMap/showland_uro.aspx"

    agent = Mechanize.new
    page = agent.get(uri1)
    form1 = page.form('aspnetForm')
    
    #fields = form1.fields do |f|
    #    puts f     
    #end
    
    puts "__EVENTVALIDATION=#{form1['__EVENTVALIDATION']}"

    form1['__EVENTTARGET'] = 'ctl00$ContentPlaceHolder1$RadioButtonList1$0'
    form1['__EVENTARGUMENT'] = ''
    form1['ctl00$ContentPlaceHolder1$ScriptManager1'] = 'ctl00$ContentPlaceHolder1$UpdatePanel1|ctl00$ContentPlaceHolder1$RadioButtonList1$0'
    form1['ctl00$ContentPlaceHolder1$RadioButtonList1'] = 'http://163.29.37.171/planMap/showland_uro.aspx'

    res = agent.submit(form1)
    res.forms.each do |f|
        puts f.name
    end
    #form2 = res.form('Form1')
    #fields = form2.fields
    #fields.each do |f|
    #    puts f.name
    #end

# POST 1
=begin
    form2= page.form('Form1')
    
    form2. = "radKind2"
    form.optArea = dist
    form.optSect = sec
    form.txtMono1 = num_major
    form.txtSbno1 = num_minor
=end

    header = {
        'Referer' => uri1,
        'Origin' => "http://163.29.37.171",
        'Connection' => "keep-alive"
    }
    
    body1 = {
        'ctl00$ContentPlaceHolder1$ScriptManager1' => 'ctl00$ContentPlaceHolder1$UpdatePanel1|ctl00$ContentPlaceHolder1$RadioButtonList1$0',
        '__EVENTTARGET' => 'ctl00$ContentPlaceHolder1$RadioButtonList1$0',
        '__EVENTTARGUMENT' => '',
        '__LASTFOCUS' => '',
        '__VIEWSTATE' => '',
        '__EVENVALIDATION' => '',
        
        'ctl00$txtUserId' => '',
        'ctl00$txtUserPwd' => '',
        'ctl00$ContentPlaceHolder1$RadioButtonList1' => 'http://163.29.37.171/planMap/showland_uro.aspx'
    }

    body2 = {
        '__EVENTTARGET' => '',
        '__EVENTTARGUMENT' => '',
        '__LASTFOCUS' => '',
        '__VIEWSTATE' => '',
        '__EVENVALIDATION' => '',
        'imgSearch.x' => 0,
        'imgSearch.y' => 0,
        'optArea' => dist,
        'optSect' => sec,
        'radKind' => "radKind2",
        'txtMono1' => num_major,
        'txtSbno1' => num_minor
    }

    end

getURProgress('中正區', '永昌段一小段', '0031', '0004')



