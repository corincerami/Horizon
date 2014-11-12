def translate(sentence)
  vowels = ["a", "e", "i", "o", "u"]
  sentence = sentence.split(" ")

  sentence.map! do |word|
    word.downcase!
    word = word.split("")
    # if the word does not begin with a vowel
    if !vowels.include?(word[0])
      # find the index at which the first vowel appears
      vowel_index = word.find_index { |i| vowels.include?(i) }
      # for all letters before the first vowel
      word << word.shift(vowel_index)
      word.join + "ay"
    else # if the word does begin with a vowel
      word.join + "way"
    end
  end
  sentence.join(" ")
end

input = ARGV.join(" ")
puts translate(input)
