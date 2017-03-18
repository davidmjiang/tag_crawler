require 'spec_helper'

describe TagCrawler do
	describe '#validate_url' do
		let(:main){TagCrawler::Main.new}
		it "assumes http:// if URL is missing transport protocol" do
			url = "pitchbook.com/about-pitchbook"
			expect(main.validate_url(url)).to eq("http://pitchbook.com/about-pitchbook")
		end
		it "does not allow transport protocols other than http:// or https://" do
			url = "foobar://pitchbook.com"
			expect{main.validate_url(url)}.to output("URL must have http or https protocol\n").to_stdout
		end
	end
end
