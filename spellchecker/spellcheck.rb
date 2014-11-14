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

def extra_letters(word)
  # check for extra letters
  for i in 0..word.length - 1
    new_word = "" + word
    new_word.slice!(i)
  end
  new_word
end

def missing_letters(word)
  # check for missing letters
  new_word_array = []
  for i in 0..word.length - 1
    for letter in "a".."z"
      new_word = "" + word
      new_word_array << new_word.insert(i, letter)
    end
  end
  new_word_array
end

def swapped_letters(word)
 # check for swapped letters
 new_word_array = []
 for i in 0..word.length - 2
  # creates new_word while conserving original
  new_word = "" + word
  # ugly way of swapping two characters
  a = new_word[i]
  b = new_word[i + 1]
  new_word[i] = b
  new_word[i + 1] = a
  new_word_array << new_word
 end
 new_word_array
end

def replace_word(word)
  possible_words = Hash.new("ERROR")
  new_word = extra_letters(word)
  if $frequencies.keys.include?(new_word)
    possible_words[new_word] = $frequencies[new_word]
  end
  new_word_array = missing_letters(word)
  new_word_array.each do |new_word|
    possible_words[new_word] = $frequencies[new_word]
  end
  new_word_array = swapped_letters(word)
  new_word_array.each do |new_word|
    possible_words[new_word] = $frequencies[new_word]
  end
  possible_words.key(possible_words.values.max).to_s
end

def correct(sentence)
  start_time = Time.new
  words = sentence.scan(/\w+/)
  total_words = 0
  corrected_words = 0
  words.each do |word|
    total_words += 1
    unless $frequencies.keys.include?(word.downcase)
      corrected_words += 1
      sentence.sub!(word, replace_word(word))
    end
  end
  puts "Total words checked: #{total_words}"
  puts "Words corrected: #{corrected_words}"
  puts "Percent corrected: #{corrected_words.to_f / total_words * 100}"
  end_time = Time.new
  time_taken = end_time - start_time
  puts "Time taken to check (in seconds): #{time_taken}"
  puts "#{total_words / time_taken} words checked per second"
  sentence
end

# birkbeck.txt is a massive log of english misspellings for testing
input = File.read("birkbeck.txt")
#input = ARGV.join(" ")
#puts correct(input)

File.open("frequencies.txt", "w+"){ |f| f.write($frequencies) }
File.open("corrections.txt", "w+"){ |f| f.write(correct(input))}
