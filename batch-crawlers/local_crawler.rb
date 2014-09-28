#!/usr/bin/env ruby
# encoding: utf-8
# ========================================
# Offline batch crawler w/o API, which is faster 
# Solring Lin 2014/09/26
# ========================================

require 'rubygems'
require '../crawler'

if ARGV.length < 1
    puts "usage: ruby local_crawler.rb [list file]"
    exit 0
end
filename = ARGV[0]
puts filename


File.open(filename, 'r') do |fd|
File.open(filename+".result", 'w') do |fdout|
    while line = fd.gets
        tokens = line.split(',')
        if tokens.length > 2
            # get land number
            num = tokens[1].strip
            num = '0'*(8-num.length) + num
            major = num[0,4]
            minor = num[4,8]
            res = getURProgress(tokens[0], major, minor)
            puts res
            fdout.write("#{tokens[0]},#{num},#{res}\n")
            sleep(3)
        end
    end
end
end
