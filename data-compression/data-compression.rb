# YOUR CODE GOES HERE
require "pry"

def common_words(file)
  word_count = Hash.new(0)
  File.read(file).scan(/\w+/).each do |word|
    if word.length >= 6
      word_count[word.downcase] += 1
    end
  end
  most_common = word_count.sort_by { |_, count| count }.reverse.first(99999)
  compression_hash = {}
  i = 0
  most_common.each do |word, count|
    compression_hash[i] = word
    i += 1
  end
  compression_hash
end

def compress(file)
  original_size = File.read(file).size
  compression_hash = common_words(file)
  text = File.read(file)
  compression_hash.each do |number, word|
    text.gsub!(word, "*#{number.to_s}*")
  end
  File.open("c-#{file}", "w") { |f| f.write(text) }
  final_size = File.read("c-#{file}").size.to_f
  rate = final_size / original_size * 100
end

def uncompress(file)
  text = File.read("c-#{file}")
  compression_hash = common_words(file)
  compression_hash.each do |number, word|
    text.gsub!("*#{number.to_s}*", word)
  end
  File.open("u-#{file}", "w") { |f| f.write(text) }
  original = File.read(file)
  final = File.read("u-#{file}")
  original == final
end

file = ARGV[1]
option = ARGV[0]


if option == "-c"
  # compresses the file
  compression_rate = compress(file)
  puts "File #{file} was compressed into c-#{file}."
  puts "Compression rate of #{compression_rate.round(2)}"
elsif option == "-u"
  # uncompresses the file
  uncompressed_file = uncompress(file)
  puts "File c-#{file} uncompressed into u-#{file}."
  puts "Lossless status is #{uncompressed_file}."
else
  # asks the user to enter the command in the proper format
  puts "Please enter in the following format:"
  puts "ruby data-compression.rb -c file"
  puts "or"
  puts "ruby data-compression.rb -u file"
end
