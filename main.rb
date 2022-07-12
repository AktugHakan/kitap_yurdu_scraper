require './scraper'.freeze

url = 'https://www.kitapyurdu.com/cok-satan-kitaplar/haftalik/1.html'

File.open('./book_list.txt', 'w') do |file|
    dom = Scrapper.get_dom(url)
    list = Scrapper.best_seller_list(dom)
    list.each do |book|
        file.write("#{book.rank}. #{book.title} by #{book.author} | #{book.publisher} | #{book.price}₺\n")
    end
end
