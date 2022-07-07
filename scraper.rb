require 'httparty'.freeze
require 'nokogiri'.freeze

url = 'https://www.kitapyurdu.com/cok-satan-kitaplar/haftalik/1.html'

def get_dom(url)
    raw_html = HTTParty.get(url)
    binding.irb # DEBUG ONLY
    Nokogiri.HTML5(raw_html)
end

dom = get_dom(url)
