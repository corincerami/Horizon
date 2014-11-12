puts "Guess a number between 1 and 1000"
guess = gets.chomp.to_i
answer = rand(1001)

until guess == answer
  if guess > answer
    puts "Too high, try again"
    guess = gets.chomp.to_i
  elsif guess < answer
    puts "Too low, try again"
    guess = gets.chomp.to_i
  end
end

puts "Congratulations, you guessed the number!"
