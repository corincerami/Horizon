doors = [true, false, false].shuffle!
guess = rand(3)

def host_reveals_door(doors, guess)
  # finds the index of the winning door
  car = doors.index(true)
  # sets the revealed_door to a random number until it's something
  # that isn't the winner or the original guess
  revealed_door = rand(3)
  while revealed_door == guess || revealed_door == car
    revealed_door = rand(3)
  end
  revealed_door
end

def switch(doors, guess)
  # sets revealed_door to the result of the appropriate method
  revealed_door = host_reveals_door(doors, guess)
  # sets second_choice to a random number until it's something
  # that isn't the original guess or the revealed door
  second_choice = rand(3)
  while second_choice == guess || second_choice == revealed_door
    second_choice = rand(3)
  end
  second_choice
end

def switch_simulation(n, guess)
  # keeps track of wins through the switching strategy
  wins = 0.0
  # runs the simulation for the inputted number of times
  n.times do
    doors = [true, false, false].shuffle!
    # sets second_choice to the result of the switch method
    second_choice = switch(doors, guess)
    # if second_choice is true in the doors array, add to wins
    wins += 1 if doors[second_choice]
  end
  puts "With switching: #{(wins / n * 100).round(2)}"
end

def no_switch_simulation(n, doors)
  # keeps track of wins through the no switching strategy
  wins = 0.0
  # runs the simulation n times
  n.times do
    # sets guess to a random door
    guess = doors.sample
    # if guess is true from the doors array, add to wins
    wins += 1 if guess
  end
  puts "Without switching: #{(wins / n * 100).round(2)}"
end

n = ARGV[0].to_i

puts "Percentage games guessed correctly:"

switch_simulation(n, guess)
no_switch_simulation(n, doors)
