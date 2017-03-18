module TagCrawler

	class FileWriter
		def initialize(filename)
			@filename = filename
		end

		def write(links, tags, sequences)
			t = Time.now
			#unique timestamp for output file
			file = t.strftime("%Y%m%d%H%M%S") + "_" + @filename
			open("./output/#{file}", 'w') do |f|
				f.puts "Links"
				f.puts "......."
				links.each do |link|
					f.puts link
				end
				f.puts "Tags"
				f.puts "......."
				f.puts tags.join("")
				f.puts "Sequences"
				f.puts "......."
				sequences.each do |seq|
					f.puts seq
				end
				puts "output/#{file} created"
			end
		end
	end

end