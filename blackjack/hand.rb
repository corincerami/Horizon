class Hand
  attr_reader :cards, :score
  def initialize(cards)
    @cards = cards
    @score = calculate_value
  end

  def calculate_value
    @score = 0
    @cards.each do |card|
      if card.face_card?
        @score += 10
      elsif !card.ace?
        @score += card.number.to_i
      end
    end
    @cards.each do |card|
      if card.ace?
        aces_value(card)
      end
    end
    @score
  end

  def aces_value(card)
    if @score > 10
      @score += 1
    elsif @score <= 10
      @score += 11
    end
  end

  def busted?
    @score > 21
  end

end
