player_points = 0
pc_points = 0

win = {
  "s" => "p l",
  "p" => "r k",
  "r" => "l s",
  "l" => "k p",
  "k" => "s r",
}

names = {
  "s" => "scissors",
  "r" => "rock",
  "p" => "paper",
  "l" => "lizard",
  "k" => "Spock"
}

until player_points == 2 || pc_points == 2
  puts "Player Score: #{player_points}, Computer Score: #{pc_points}"
  puts "Choose rock(r), paper(p), scissors(s), lizard(l), or Spock(k)."
  choice = gets.chomp

  # double commented out lines were refactored and left in for my own reference
  ## if choice == "r" || choice == "p" || choice == "s"
  # rather than hard coding what choices can be, check hash "win"
  if win.include?(choice)
    ## hands = ["r", "p", "s"]
    ## pc_choice = hands[rand(3)]
    # rather than creating a separate array, pc_choice can pull from has "win"
    pc_choice = win.keys[rand(5)]
    puts "Player chose #{names[choice]}."
    puts "Computer chose #{names[pc_choice]}."
    if choice == pc_choice
      puts "Tie, choose again."
    else
      ## if (choice == "r" && pc_choice == "s") || (choice == "p" && pc_choice
      ## == "r") || (choice == "s" && pc_choice == "p")
      # rather than hard code in win/lose scenarios, checking "win" hash allows
      # for easier changes, such as adding lizard and spock. Before this it
      # was checking to see that the hash key corresponded to a specific value
      # and each scenario was a separate key/value in the win hash, but this led
      # to confusion once there were duplicate scenarios, such as r beating s
      # and also beating l. Now any number of combination can be added
      # as long as they have a unique character representing them.
      if win[choice].include?(pc_choice)
        player_points += 1
        puts "#{names[choice].capitalize} beats #{names[pc_choice]}, player wins the round."
      ## elsif (pc_choice == "r" && choice == "s") ||
      ## (pc_choice == "p" && choice == "r") ||
      ## (pc_choice == "s" && choice == "p")
      # same as line 26
    elsif win[pc_choice].include?(choice)
        pc_points += 1
        puts "#{names[pc_choice].capitalize} beats #{names[choice]}, computer wins the round."
      end
    end
  else
    puts "Invalid entry, try again."
  end
end

# This seems unnecessary but I was messing around with D-R-Y techniques.
# Originally it simply puts "Player wins!" else "Computer wins!"
# Doesn't really save any time or lines of code, but I felt like experimenting
# with cutting as much repetition as possible.
if player_points == 2
  winner = "Player"
else
  winner = "Computer"
end

puts "#{winner} wins!"
