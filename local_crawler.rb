#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems'
require './crawler'

if ARGV.length < 1
    puts "usage: ruby local_crawler.rb [list file]"
    exit 0
end
filename = ARGV[0]
puts filename

lines = filename.readline
for l in lines
    
end
