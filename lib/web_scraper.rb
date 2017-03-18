require 'nokogiri'
require 'httparty'

module TagCrawler

	class WebScraper
		TAG = /\<[^<>]+\>/
		OPENING_TAG = /\<(\w+)(\>|\s([^\/]+)\>)/
		CLOSING_TAG = /<\/(\w+)>/
		SELF_CLOSING_TAG = /\<(\w+)(\/\>|\s*(.*)\/\>)/

		def initialize(url)
			begin
				response = HTTParty.get(url)
			rescue
				puts "Error: Failed to connect to #{url}"
				exit
			end
			@html_string = response.body
			@html_doc = Nokogiri::HTML(@html_string)
		end

		def get_links()
			links = []
			@html_doc.xpath("//a").each do |link|
				links << link.attributes["href"].value
			end
			links
		end

		def get_tags()
			tags = []
			tag_strings = @html_string.scan(TAG)
			tag_strings.each do |tag|
				if(tag_is_opener?(tag))
					tags.push("<#{OPENING_TAG.match(tag)[1]}>")
				elsif(tag_is_closer?(tag))
					tags.push("</#{CLOSING_TAG.match(tag)[1]}>")
				elsif(tag_is_self_closing?(tag))
					tags.push("<#{SELF_CLOSING_TAG.match(tag)[1]}>")
					tags.push("</#{SELF_CLOSING_TAG.match(tag)[1]}>")
				end
			end
			tags
		end

		def get_sequences
			nodes = get_text_nodes(@html_doc)
			find_sequences(nodes)
		end

		private

		def get_text_nodes(page)
			page.xpath("//html/descendant::text()").map{|node| node.text}
		end

		def find_sequences(nodes)
			sequences = []
			nodes.each do |node|
				words = node.split(" ")
				current_sequence = []
				words.each_with_index do |word, idx|
					if(word[0] == word[0].upcase)
						current_sequence << word
					elsif(current_sequence.length >= 2)
						sequences << current_sequence.join(" ")
						current_sequence = []
					else
						current_sequence = []
					end
					if(idx == words.length-1 && current_sequence.length >= 2)
						sequences << current_sequence.join(" ")
					end
				end
			end
			sequences
		end

		def tag_is_opener?(tag)
			(OPENING_TAG =~ tag) == 0
		end

		def tag_is_closer?(tag)
			(CLOSING_TAG =~ tag) == 0
		end

		def tag_is_self_closing?(tag)
			(SELF_CLOSING_TAG =~ tag) == 0
		end
		
	end

end