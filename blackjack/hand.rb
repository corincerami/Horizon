class Hand
  attr_reader :cards, :score
  def initialize(cards)
    @cards = cards
    @score = 0
    @cards.each do |card|
      @score += calculate_value(card)
    end
  end

  def calculate_value(card)
    if card.face_card?
      value = 10
    elsif card.ace?
      value = aces_value(card)
    else
      value = card.number.to_i
    end
    binding.pry
    @score += value
  end

  def aces_value(card)
    if @score > 10 && card.ace?
      1
    elsif @score <= 10 && card.ace?
      11
    end
  end

end
