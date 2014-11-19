#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'mongo'

#Working on Windows 8 with an active Mongo instance and the Nokogiri and Mongo gems installed

#Simple script that scans trollandtoad for the price of Prodigal Pyromancers and tosses them in Mongodb
#Define the mongo collection we'll be saving to
db = Mongo::Connection.new.db('price_data')
col = db.collection("cards")

#Create an array, read the data from the Nokogiri stream, and save it within that array
ctr = Array.new
doc = Nokogiri::HTML(open("http://www.trollandtoad.com/products/search.php?search_category=&search_words=prodigal+pyromancer"))
doc.css('.price_text').each do |node|
	ctr.push(node.content)
end

#Save the array in mongo
col.save({ card: "Prodigal Pyromancer", price_array: ctr })

#Output so you can see the document that was created
puts col.find_one