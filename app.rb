#!/usr/bin/env ruby

require 'rubygems'
require 'erb'
require 'json'
require 'sinatra'
require 'sinatra/content_for'
require './crawler'

class SolringWebsite < Sinatra::Base
	helpers Sinatra::ContentFor
	
	set :static, true
	set :public_dir, File.dirname(__FILE__)+'/static'

    get '/byArea/:dist/:sec/:major/:minor' do
        dist = params[:dist]
        sec = params[:sec]
        major = params[:major]
        minor = params[:minor]
    
        #getURProgress(sec, major, minor)
    
    end

    get '/byArea/:dist/:sec/:num' do
  
        dist = params[:dist]
        sec = params[:sec]
        num = params[:num]
        if num.length != 8
            return 'invalid number'
        end
        major = num[0..3]
        minor = num[4..7]

        #getURProgress(sec, major, minor)
        #erb :index, :locals => {:pictures => pics}
    end
    
    
    get '/bySec/:sec/:major/:minor' do
        sec = params[:sec]
        major = params[:major]
        minor = params[:minor]
        
        #getURProgress(sec, major, minor)
    end
    
    get '/bySec/:sec/:major/:minor' do
        sec = params[:sec]
        num = params[:num]
        if num.length != 8
            return 'invalid number'
        end
        major = num[0..3]
        minor = num[4..7]
        
        #getURProgress(sec, major, minor)
    end

  run! if app_file == $0
end
