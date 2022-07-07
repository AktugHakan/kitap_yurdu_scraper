require 'httparty'.freeze
require 'nokogiri'.freeze

url = 'https://www.kitapyurdu.com/cok-satan-kitaplar/haftalik/1.html'

def scrapper
    raw_html = httparty.get(url)
    Nokogiri.HTML5(raw_html)
end
