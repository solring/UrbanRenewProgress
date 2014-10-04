#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'mongo'

include Mongo

if ARGV.length < 1
	print "usage: ruby insert_todb.rb [input json file]"
	exit(1)
end


mongo_client = MongoClient.new("kahana.mongohq.com", 10068)
db = mongo_client.db("app28378937")
db.authenticate("solring", "sl460852")

collection = db.collection("TPEPOP-URP")
collection.drop()

fd = open(ARGV[0], 'r')
jdatas = JSON.parse(fd.read())
jdatas.each do |jdata|
	puts "insert #{jdata["section"]}, #{jdata["number"]}"
	collection.insert(jdata)
end
fd.close()
