class Book
    def initialize(title, author, publisher, price, rank)
        raise TypeError, '"rank" should be a positive integer' unless (rank.is_a? Integer) && rank.positive?
        raise TypeError, '"price" should be a positive float' unless (price.is_a? Float) && price.positive?

        @title = title
        @author = author
        @publisher = publisher
        @price = price
        @rank = rank
    end
end
