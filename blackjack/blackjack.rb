#!/usr/bin/env ruby
require "pry"
require_relative "card"
require_relative "deck"
require_relative "hand"

deck = Deck.new

# dealing two cards to player for initial hand
player_hand = Hand.new(deck.cards.pop(2))
player_hand.cards.each do |card|
  puts "Player was dealt #{card.number} of #{card.suit}"
end

# prompt player to hit or stand until stand or bust
while player_hand.score < 21
  puts "Player's score: #{player_hand.score}"
  print "Hit or stand (H/S): "
  response = gets.chomp.downcase
  if response == "h"
    new_card = deck.cards.pop
    player_hand.cards << new_card
    player_hand.calculate_value
    puts "Player was dealt #{new_card.number} of #{new_card.suit}"
  elsif response == "s"
    puts "Player stands"
    puts "Player's score: #{player_hand.score}"
    break
  else
    puts "Please enter either h or s"
  end
end

# check if player has busted
if player_hand.busted?
  puts "Bust. You lose..."
  exit
end

# deal two cards to dealer as initial hand
dealer_hand = Hand.new(deck.cards.pop(2))
dealer_hand.cards.each do |card|
  puts "Dealer was dealt #{card.number} of #{card.suit}"
end

# dealer hits or stands until bust or stand
while dealer_hand.score < 21
  puts "Dealer's score: #{dealer_hand.score}"
  if dealer_hand.score < 17
    new_card = deck.cards.pop
    dealer_hand.cards << new_card
    dealer_hand.calculate_value
    puts "Dealer was dealt #{new_card.number} of #{new_card.suit}"
  else
    puts "Dealer stands"
    break
  end
end

def who_won(player_hand, dealer_hand)
  if player_hand.score > dealer_hand.score
    "You win"
  elsif dealer_hand.score > player_hand.score && !dealer_hand.busted?
    "Dealer wins"
  elsif dealer_hand.busted?
    "Bust. You win"
  elsif player_hand.score == dealer_hand.score
    "Push. No one wins."
  end
end

puts who_won(player_hand, dealer_hand)
