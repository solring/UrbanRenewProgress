#!/usr/bin/env ruby
# encoding: utf-8
# ========================================
# Offline batch crawler w/o API, which is faster 
# Solring Lin 2014/09/26
# ========================================

require 'rubygems'
require '../crawler'

puts ARGV.length
if ARGV.length < 3
    puts "usage: ruby local_crawler.rb [list file] [sec col #] [num col #] [offset]"
    exit 0
end
filename = ARGV[0]
sec_col = ARGV[1].to_i
num_col = ARGV[2].to_i
offset = ARGV[3].to_i

if sec_col < 0 or num_col < 0
    puts "section column or land# column out of bound"
    exit 0
end

puts "land list: #{filename}"
count = 0

File.open(filename, 'r') do |fd|
File.open(filename+".result", 'w') do |fdout|
    while line = fd.gets
        # skip lines to the offset
        count += 1
        next if count < offset 

        tokens = line.split(',')
        if tokens.length > 2
            
            # get land number
            num = tokens[num_col].strip
            num = '0'*(8-num.length) + num
            major = num[0,4]
            minor = num[4,8]
            
            sec = tokens[sec_col].strip()

            res = getURProgress(sec, major, minor)
            puts res
            fdout.write("#{sec};#{num};#{res}\n")
            sleep(3)
        end
    end
end
end
