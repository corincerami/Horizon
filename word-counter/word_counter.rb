file = ARGV[0]
number = ARGV[1].to_i
stop_words = File.read("stop_words.txt")

def count_words(file, stop_words)
  word_hash = Hash.new(0)
  File.read(file).scan(/\w+/).each do |word|
    unless stop_words.include?(word.downcase)
      word_hash[word.downcase] += 1
    end
  end
  word_hash
end

word_hash = count_words(file, stop_words)

def print_words(word_hash, number)
  word_hash = word_hash.sort_by { |_, count| -count }
  word_hash.first(number).each do |word, count|
    puts "#{word}: #{count}"
  end
end

print_words(word_hash, number)
