#!/usr/bin/env ruby

require 'rubygems'
require 'erb'
require 'json'
require 'sinatra'
require 'sinatra/content_for'
require './crawler'

class UrbanRenewProgress < Sinatra::Base
	helpers Sinatra::ContentFor
	
	set :static, true
	set :public_dir, File.dirname(__FILE__)+'/static'

    get '/byArea/:dist/:sec/:major/:minor' do
        dist = params[:dist]
        sec = params[:sec]
        major = params[:major]
        minor = params[:minor]

        if major.length != 4 or minor.length != 4
            return 'ERROR: invalid number'
        end
    
        return getURProgress(sec, major, minor)
    
    end

    get '/byArea/:dist/:sec/:num' do
  
        dist = params[:dist]
        sec = params[:sec]
        num = params[:num]
        if num.length != 8
            return 'ERROR: invalid number'
        end
        major = num[0..3]
        minor = num[4..7]

        return getURProgress(sec, major, minor)
        #erb :index, :locals => {:pictures => pics}
    end
    
    
    get '/bySec/:sec/:major/:minor' do
        sec = params[:sec]
        major = params[:major]
        minor = params[:minor]
        if major.length != 4 or minor.length != 4
            return 'ERROR: invalid number'
        end
        
        return getURProgress(sec, major, minor)
    end
    
    get '/bySec/:sec/:num' do
        sec = params[:sec]
        num = params[:num]
        if num.length != 8
            return 'ERROR: invalid number'
        end
        major = num[0..3]
        minor = num[4..7]
        
        return getURProgress(sec, major, minor)
    end

  run! if app_file == $0
end

