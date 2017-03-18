require "tag_crawler/version"
require_relative "web_scraper"
require_relative "file_writer"

module TagCrawler

PROTOCOL = /:\/\//
VALID_PROTOCOLS = ["http", "https"]

class Main
	def run
		validate_args
		scraper = TagCrawler::WebScraper.new(@url)
		puts "getting links..."
		links = scraper.get_links
		puts "getting tags..."
		tags = scraper.get_tags
		puts "getting sequences..."
		sequences = scraper.get_sequences
		puts "creating file..."
		file_writer = TagCrawler::FileWriter.new(ARGV[1])
		file_writer.write(links, tags, sequences)
	end

	def validate_args
		if ARGV.length != 2
			puts "Error: You must provide 2 arguments: a url and a filename."
			exit
		end
		validate_url(ARGV[0])
	end

	def validate_url(url)
		@url = url
		url_protocol = @url.match(PROTOCOL)
		# if no protocol, add http://
		if(url_protocol.nil?)
			@url = "http://" + @url
		# print error if not valid protocol
		elsif(!VALID_PROTOCOLS.include?(url_protocol.pre_match))
			puts "Error: URL must have http or https protocol"
			exit
		end
	end

end

end
