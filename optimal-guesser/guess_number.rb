def guess_number(min, max)
  # You can call the `check` method with a number to see if it
  # is the hidden value.
  #
  # If the guess is correct, it will return 0.
  # If the guess is too high, it will return 1.
  # If the guess is too low, it will return -1.
  #
  # If you call `check` too many times, the program will crash.
  #
  # e.g. if the hidden number is 43592, then
  #
  # check(50000) # => 1
  # check(40000) # => -1
  # check(43592) # => 0
  #
  # When you've figured out what the hidden number is, return it
  # from this method.
  low = min
  high = max
  guess = (min + max) / 2
  x = check(guess)
  until x == 0
    x = check(guess)
    if x == 1
      high = guess
      guess = (guess + low) / 2
      puts "#{guess}"
    elsif x == -1
      low = guess
      guess = (guess + high) / 2
      puts "#{guess}"
    end
  end
  guess
end
