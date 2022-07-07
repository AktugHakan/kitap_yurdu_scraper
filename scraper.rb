require 'httparty'.freeze
require 'nokogiri'.freeze

url = 'https://www.kitapyurdu.com/cok-satan-kitaplar/haftalik/1.html'

module Scrapper
    def get_dom(url)
        raw_html = HTTParty.get(url)
        binding.irb # DEBUG ONLY
        return Nokogiri.HTML5(raw_html)
    end

    def best_seller_list(dom)
        raise TypeError, 'Expected a parsed HTML file.' unless dom.respond_to? 'css'

        product_cr_list = dom.css('div.product-cr')
        product_cr_list.each do |product_cr|
            #TODO
        end
    end
end
