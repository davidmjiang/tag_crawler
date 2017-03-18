require 'spec_helper'

describe TagCrawler do
	let(:scraper){TagCrawler::WebScraper.new("test")}
	let(:html_doc){Nokogiri::HTML('<html><head><link rel="stylesheet" href="styles.css"/></head><body><a href="link">Link</a><a href="link2">Here\'s another link</a></body>')}
	let(:html_string){'<html><head><link rel="stylesheet" href="styles.css"/></head><body><a href="link">Link</a><a href="link2">Here\'s another link</a></body>'}

	describe '#get_links' do
		before do
			HTTParty.stub(:get).and_return(double("response", :body => html_string))
		end
		it 'gets all the links on the page' do
			expect(scraper.get_links.length).to eq(2)
		end
		it "returns the href attribute for each link" do
			expect(scraper.get_links[0]).to eq("link")
		end
	end

	describe '#get_tags' do
		before do
			HTTParty.stub(:get).and_return(double("response", :body => html_string))
		end
		it 'gets all tags' do
			expect(scraper.get_tags).to eq(["<html>", "<head>", "<link>", "</link>", "</head>", "<body>","<a>", "</a>", "<a>", "</a>", "</body>"])
		end
	end
	
	describe '#get_sequences' do
		let(:html_string2){'<html><head><title>Title of Page</title</head><body><h1>Leadership</h1><p>CEO <span>John Boss</span></p><p>CTO Foo Bar</p></body>'}
		before do
			HTTParty.stub(:get).and_return(double("response", :body => html_string2))
		end
		it 'should return a collection of sequences each at least two or more words and each word capitalized' do
			expect(scraper.get_sequences). to eq(["John Boss", "CTO Foo Bar"])
		end
	end
end