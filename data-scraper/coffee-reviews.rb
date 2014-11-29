#!/usr/bin/env ruby
require "net/http"
require "nokogiri"
require "open-uri"
require "pry"

doc = Nokogiri::HTML(open("http://www.amazon.com/Drip-Coffee-Machines-Makers/b?ie=UTF8&node=289745"))

results = doc.css("span.a-declarative a").map { |link| link['href'] }

# finds the individual sentences from all reviews
review_sentences = []
results.each do |url|
  review_doc = Nokogiri::HTML(open(url, {"User-Agent" => "Some Browser"}))
  ratings = review_doc.css("span.crAvgStars a")
  reviews = review_doc.css("div.reviewText")
  review_sentences = reviews.to_s.split(".")
  print "."
end
puts ""

# finds the most common words in reviews
def count_words(reviews, stop_words)
  word_hash = Hash.new(0)
  reviews.each do |review|
    review.split(" ").each do |word|
      unless stop_words.include?(word.downcase)
        word_hash[word.downcase] += 1
      end
    end
  end
  word_hash.sort_by { |word, count| -count }.first(10)
end

# these were common words found that didn't seem to contribute to a review's sentiment
stop_words = ["the", "i", "and", "a", "it", "to", "is", "of", "br", "you", "this", "that", "for", "in", "on", "t",
              "s", "but", "have", "with", "if", "my", "div", "when", "can", "about", "so", "one", "has", "as", "too",
              "just", "be", "back", "was", "or", "are", "your", "out", "there", "reviewtext", "from", "lid", "will", "after", "all"]

common_words = count_words(review_sentences, stop_words)

sentences = Hash.new(0)
review_sentences.each do |sentence|
  common_words.each do |word|
    if sentence.split(" ").include?(word[0])
      sentences[sentence] += 1
    end
  end
end

sentences.sort_by { |sentence, count| -count }.first(10).each do |array|
  puts array[0]
end

