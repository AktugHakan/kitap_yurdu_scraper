require 'httparty'.freeze
require 'nokogiri'.freeze
require './product'.freeze

# Set of tools to GET and parse a website
module Scrapper
    def self.get_dom(url)
        raw_html = HTTParty.get(url)
        dom = Nokogiri.HTML5(raw_html)
        if dom.errors.any?
            print '---ERROR!---'.freeze
            dom.errors.each do |error|
                print "    #{error}"
            end
            raise "Couldn't parse the document!"
        end
    end

    def self.product_cr_renderer(product_cr)
        raise TypeError, 'Expected a parsed HTML fragment/file.' unless product_cr.respond_to? 'css'

        rank = product_cr.css('div.bestseller-rank > div').text.to_i
        title = product_cr.css('div.name.ellipsis').text.strip
        author = product_cr.css('div.author > span').text.strip
        publisher = product_cr.css('div.publisher').text.strip
        # Converting comma to dot because to_f does not work with comma.
        price = product_cr.css('div.price-new > span.value').text.sub(',', '.').to_f
        return Book.new title, author, publisher, price, rank
    end

    def self.best_seller_list(dom)
        raise TypeError, 'Expected a parsed HTML fragment/file.' unless dom.respond_to? 'css'

        books = []
        product_cr_list = dom.css('div.product-cr')
        product_cr_list.each do |product_cr|
            book = product_cr_renderer(product_cr)
            books.append(book)
        end

        return books
    end

    def next_page_url(dom)
        raise TypeError, 'Expected a parsed HTML fragment/file.' unless dom.respond_to? 'css'

        dom.css('div.pagination > a.next')
    end
end
