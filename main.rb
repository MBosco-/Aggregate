#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'mongo'

#Simple script that scans trollandtoad for the price of Prodigal Pyromancers and tosses them in Mongodb
db = Mongo::Connection.new.db('price_data')
col = db.collection("cards")

ctr = Array.new
doc = Nokogiri::HTML(open("http://www.trollandtoad.com/products/search.php?search_category=&search_words=prodigal+pyromancer"))
doc.css('.price_text').each do |node|
	ctr.push(node.content)
end
col.save({ card: "Prodigal Pyromancer", price_array: ctr })
puts col.find_one