#!/usr/bin/env ruby
require "pry"
require_relative "card"
require_relative "deck"
require_relative "hand"

  suits = ["hearts", "diamonds", "spades", "clubs"]
  numbers = ["A", "2", "3", "4", "5", "6", "7",
             "8", "9", "10", "J", "Q", "K"]

deck = Deck.new(suits, numbers)

player_hand = Hand.new(deck.cards.pop(2))
player_hand.cards.each do |card|
  puts "Player was dealt #{card.number} #{card.suit}"
end

dealer_hand = Hand.new(deck.cards.pop(2))
dealer_hand.cards.each do |card|
  puts "Dealer was dealt #{card.number} #{card.suit}"
end

binding.pry

while player_hand.score < 21
  puts "Player's score: #{player_hand.score}"
  puts "Hit or stand (H/S): "
  response = gets.chomp.downcase
  if response == "h"
    new_card = deck.cards.pop
    hand.calculate_value(new_card)
    player_hand.cards << new_card
    puts "Player was dealt #{card.number} #{card.suit}"
  elsif response == "s"
    break
  else
    puts "Please enter either y or n"
  end
end

def who_won

end

who_won
