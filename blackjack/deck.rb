class Deck
  attr_reader :cards
  def initialize(suits, numbers)
    @cards = []
    suits.each do |suit|
      numbers.each do |number|
        @cards << Card.new(suit, number)
      end
    end
    @cards.shuffle!
  end

  suits = ["hearts", "diamonds", "spades", "clubs"]
  numbers = ["A", "2", "3", "4", "5", "6", "7",
             "8", "9", "10", "J", "Q", "K"]
end
