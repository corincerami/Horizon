require "pry"

# captures the filename and either (-c)ompress or (-u) uncompress
file = ARGV[1]
option = ARGV[0]

def count_words(file)
  word_count = Hash.new(0) # default value for hash is 0
  File.read(file).scan(/\w+/).each do |word| # returns an array
    if word.length >= 3 # ignore words with 1 character
      word_count[word] += 1 # increase the count in the hash
    end
  end
  word_count
end

word_count = count_words(file)

def common_words(file, word_count) # builds a hash from file
  # saves a hash of the most common words
  number = word_count.length
  most_common = word_count.sort_by { |_, count| count }.reverse.first(number)
  compression_hash = {}
  i = 124 # starting with UTF-8 124 because 1-123 are letters/whitespace
  most_common.each do |word, _| # for each of the most common words
    # uses UTF-8 chars not ASCII to facilitate uncompression
    compression_hash[i.chr(Encoding::UTF_8)] = word
    i += 1
  end
  compression_hash
end

def compress(file, word_count)
  original_size = File.read(file).size
  compression_hash = common_words(file, word_count) # grabs hash from common_words method
  text = File.read(file) # saves entire file as a string
  compression_hash.each do |char, word| # for each pair in compression_hash
    text.gsub!(word, char) # replace word in file with UTF-8 character
  end
  File.open("c-#{file}", "w") { |f| f.write(text) } # writes a new file
  # to preserve the original file, in case of compression errors
  final_size = File.read("c-#{file}").size.to_f
  final_size / original_size * 100 # returns compression rate
end

def uncompress(file, word_count) # takes in input from ARGV
  text = File.read("c-#{file}") # saves entire file as a string
  compression_hash = common_words(file, word_count) # grabs hash from common_words method
  compression_hash.each do |char, word| # for each pair in compression_hash
    text.gsub!(char, word) # replaces UTF-8 char in text with word
  end
  File.open("u-#{file}", "w") { |f| f.write(text) } # saved text to a new file
  original = File.read(file)
  final = File.read("u-#{file}")
  original == final # checks whether compression was lossless
end

if option == "-c"
  # runs the compression method and outputs a message and compression rate
  compression_rate = compress(file, word_count)
  puts "File #{file} was compressed into c-#{file}."
  puts "File is now #{compression_rate.round(2)} of its original size"
elsif option == "-u"
  # runs uncompression file and out a message and checks for losslessness
  uncompressed_file = uncompress(file, word_count)
  puts "File c-#{file} uncompressed into u-#{file}."
  puts "Lossless status is #{uncompressed_file}."
else
  # asks the user to re-enter the command in the proper format
  puts "Please enter in the following format:"
  puts "ruby data-compression.rb -c file"
  puts "or"
  puts "ruby data-compression.rb -u file"
end
