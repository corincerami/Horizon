def host_reveals_door
  # finds the index of the winning door
  car = $doors.index(true)
  # sets the revealed_door to a random number until it's something
  # that isn't the winner or the original guess
  revealed_door = rand(3)
  while revealed_door == $guess || revealed_door == car
    revealed_door = rand(3)
  end
  revealed_door
end

def switch
  # sets revealed_door to the result of the appropriate method
  revealed_door = host_reveals_door

  # sets second_choice to a random number until it's something
  # that isn't the original guess or the revealed door
  second_choice = rand(3)
  while second_choice == $guess || second_choice == revealed_door
    second_choice = rand(3)
  end
  second_choice
end

def switch_simulation(n)
  # keeps track of wins through the switching strategy
  wins = 0.0

  # runs the simulation for the inputted number of times
  n.times do
    # sets guess as a global variable that is a random number between 0-2
    $guess = rand(3)
    # sets the doors as a gloval array and randomizes it
    $doors =  [true, false, false].shuffle!
    # sets second_choice to the result of the switch method
    second_choice = switch
    # if second_choice is true in the doors array, add to wins
    wins += 1 if $doors[second_choice]
  end
  wins / n * 100
end

def no_switch_simulation(n)
  # keeps track of wins through the no switching strategy
  wins = 0.0

  # runs the simulation n times
  n.times do
    # sets guess to a random door
    guess = $doors.sample
    # if guess is true from the doors array, add to wins
    wins += 1 if guess
  end
  wins / n * 100
end

n = ARGV[0].to_i

switch_chance = switch_simulation(n)
no_switch_chance = no_switch_simulation(n)

puts "Percentage games guessed correctly:"
puts "With switching: #{switch_chance.round(2)}"
puts "Without switching: #{no_switch_chance.round(2)}"

# i decided to create $doors as a global variable because the probabilities
# were not working out due to doors getting shuffled each times its method
# was called, which led to switching also winning 33% of the time. I need
# to find a way to have doors be accessible to all other methods without
# being shuffled each time
