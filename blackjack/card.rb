class Card
  attr_reader :suit, :number
  def initialize(suit, number)
    @suit = suit
    @number = number
  end

  def face_card?
    ["J", "Q", "K"].include?(number)
  end

  def ace?
    @number == "A"
  end

end
