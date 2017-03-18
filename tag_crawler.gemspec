# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tag_crawler/version'

Gem::Specification.new do |spec|
  spec.name          = "tag_crawler"
  spec.version       = TagCrawler::VERSION
  spec.authors       = ["David Jiang"]
  spec.email         = ["davidjgrey@gmail.com"]

  spec.summary       = "Extracts features from an HTMl document"
  spec.description   = "The application crawls a URL and extracts links, tags and sequences. These features are written to an output file"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["tag_crawler"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency "nokogiri"
  spec.add_runtime_dependency "httparty"
end
