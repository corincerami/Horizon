#!/usr/bin/env ruby
require "pry"

def find_frequency
  frequencies = Hash.new(0)
  # counts each word and stores counts to frequencies hash
  # creating frequencies hash as a method caused redundant
  # creation of frequencies hash and slowed the program
  # I realized that passing in the result of find_frequency
  # as a second argument would allow me to run it only once
  File.read("lotsowords.txt").scan(/\w+/).each do |word|
    frequencies[word.downcase] += 1
  end
  frequencies
end

frequencies = find_frequency

# tracks number of corrections
# $corrected_words = 0 #
# clears the corrected.txt file if it exists
# File.open("corrected.txt", "w"){ |f| f.write("")}

def extra_letters(word)
  # removes each letter
  new_word_array = []
  (0..word.length - 1).each do |i|
    new_word = "" + word
    new_word.slice!(i)
    new_word_array << new_word
  end
  new_word_array
end

def missing_letters(word)
  # adds extra letters at each point in word
  new_word_array = []
  (0..word.length).each do |i| # for each point in the word
    ("a".."z").each do |letter| # for each letter in the alphabet
      new_word = "" + word
      new_word_array << new_word.insert(i, letter) # insert each letter at each point
    end
  end
  new_word_array
end

def swapped_letters(word)
  # swaps two adjacent letters
  new_word_array = []
  (0..word.length - 2).each do |i|
    # creates new_word while conserving original
    new_word = "" + word
    # swaps adjacent letters
    new_word[i], new_word[i + 1] = new_word[i + 1], new_word[i]
    new_word_array << new_word
  end
  new_word_array
end

def replace_word(word, frequencies)
  # stores all potential corrected words
  possible_words = Hash.new
  # runs extra_letters and checks if the result is a word
  new_word_array = extra_letters(word)
  new_word_array.each do |new_word|
    if frequencies[new_word] > 0
      possible_words[new_word] = frequencies[new_word]
    end
  end
  # runs missing_letters and checks if the result is a word
  new_word_array = missing_letters(word)
  new_word_array.each do |new_word|
    if frequencies[new_word] > 0
      possible_words[new_word] = frequencies[new_word]
    end
  end
  # runs swapped_letters and checks if the result is a word
  new_word_array = swapped_letters(word)
  new_word_array.each do |new_word|
    if frequencies[new_word] > 0
      possible_words[new_word] = frequencies[new_word]
    end
  end
  # returns the most frequently used possible word
  if possible_words.length > 0
    #$corrected_words += 1
    # write corrections to file for inspection, used for testing
    # File.open("corrected.txt", "a"){ |f| f.puts("#{word} to #{possible_words.key(possible_words.values.max)}")}
    return possible_words.key(possible_words.values.max)
  else
    return word
  end
end

def correct(text, frequencies)
  # start_time = Time.new #
  # total_words = 0 #
  words = text.scan(/\w+/)
  words.each do |word|
    total_words += 1 #
    unless frequencies.keys.include?(word.downcase)
      text.sub!(word, replace_word(word, frequencies))
    end
  end
  # puts "Total words checked: #{total_words}" #
  # puts "Words corrected: #{$corrected_words}" #
  # puts "Percent corrected: #{($corrected_words.to_f / total_words * 100).round(2)}" #
  # end_time = Time.new #
  # time_taken = end_time - start_time #
  # puts "Time taken to check (in seconds): #{time_taken.round(2)}" #
  # puts "#{(total_words / time_taken).round(2)} words checked per second" #
  text
end

input = ARGV.join(" ")
puts correct(input, frequencies)

# saves a file with the corrected text
# File.open("corrected.txt", "w+"){ |f| f.write(correct(input))}
