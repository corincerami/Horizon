#!/usr/bin/env ruby
require "pry"

#def find_frequencies
  # build array from file of all words
  word_bank = File.read("lotsowords.txt").scan(/\w+/)
  $frequencies = Hash.new(0)
  # counts each word and stores counts to frequencies hash
  word_bank.each do |word|
    $frequencies[word.downcase] += 1
  end
  #frequencies
#end

def replace_word(word)
  possible_words = Hash.new("ERROR")
  #frequencies = find_frequencies
  # check for extra letters
  for i in 0..word.length - 1
    new_word = "" + word
    new_word.slice!(i)
    if $frequencies.keys.include?(new_word)
      possible_words[new_word] = $frequencies[new_word]
    end
  end
 # check for swapped words
 for i in 0..word.length - 2
  # creates new_word while conserving original
  new_word = "" + word
  # ugly way of swapping two characters
  a = new_word[i]
  b = new_word[i + 1]
  new_word[i] = b
  new_word[i + 1] = a
  if $frequencies.keys.include?(new_word)
    possible_words[new_word] = $frequencies[new_word]
  end
 end
 # check for missing letters
 for i in 0..word.length - 1
  for letter in "a".."z"
    new_word = "" + word
    new_word = new_word.insert(i, letter)
    if $frequencies.keys.include?(new_word)
      possible_words[new_word] = $frequencies[new_word]
    end
  end
 end
  possible_words.key(possible_words.values.max).to_s
end

def correct(sentence)
  #frequencies = find_frequencies
  words = sentence.scan(/\w+/)
  words.each do |word|
    unless $frequencies.keys.include?(word.downcase)
      sentence.sub!(word, replace_word(word))
    end
  end
  sentence
end

input = ARGV.join(" ")
puts correct(input)
