class Deck
  attr_reader :cards
  def initialize
    @cards = []

    suits = ["hearts", "diamonds", "spades", "clubs"]
    numbers = ["A", "2", "3", "4", "5", "6", "7",
             "8", "9", "10", "J", "Q", "K"]

    suits.each do |suit|
      numbers.each do |number|
        @cards << Card.new(suit, number)
      end
    end
    @cards.shuffle!
  end
end
