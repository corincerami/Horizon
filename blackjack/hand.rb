class Hand
  attr_reader :cards, :score
  def initialize(cards)
    @cards = cards
    calculate_value
  end

  # i took out the argument from this method so it just calculates the
  # total score, so it's calculating the score for the whole hand every
  # time you're dealt a new card
  def calculate_value
    @score = 0
    @cards.each do |card|
      if card.face_card?
        @score += 10
      elsif !card.ace?
        @score += card.number.to_i
      end
    end
    # i moved the called to ace_value out of the each loop, so that aces
    # would always be tallied last.
    @cards.each do |card|
      aces_value(card) if card.ace?
    end
  end

  # this method and the one above now add directly to score rather than
  # returning a value for each card.
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
