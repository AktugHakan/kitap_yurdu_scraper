require 'httparty'.freeze
require 'nokogiri'.freeze
require 'product.rb'.freeze

# Set of tools to GET and parse a website
module Scrapper
    def get_dom(url)
        raw_html = HTTParty.get(url)
        binding.irb # DEBUG ONLY
        return Nokogiri.HTML5(raw_html)
    end

    def product_cr_renderer(product_cr)
        raise TypeError, 'Expected a parsed HTML fragment/file.' unless dom.respond_to? 'css'

        rank = product_cr.css('div.bestseller-rank > div').text.to_i
        title = product_cr.css('div.name-ellipsis').text
        author = product_cr.css('div.author > span').text
        publisher = product_cr.css('div.publisher').text
        price = product_cr.css('div.price-new > span.value').text.to_f
        binding.irb

        return Book.new title, author, publisher, price, rank
    end

    def best_seller_list(dom)
        raise TypeError, 'Expected a parsed HTML fragment/file.' unless dom.respond_to? 'css'

        books = []
        product_cr_list = dom.css('div.product-cr')
        product_cr_list.each do |product_cr|
            book = product_cr_renderer(product_cr)
            books.append(book)
        end

        return books
    end
end
