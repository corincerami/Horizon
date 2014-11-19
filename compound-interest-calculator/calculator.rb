# The output of the program should look as follows:

# What is the amount being invested: 1000
# What is the annual interest rate (percentage): 10
# How many years will it accrue interest: 25

# The final value will be $10834.71 after 25 years.

# ====================
# YOUR CODE GOES HERE
# ====================
puts "What is the amount being invested: "
principal = gets.chomp.to_f
puts "What is the annual interest rate (percentage): "
apr = gets.chomp.to_f
puts "How many years will it accrue interest: "
years = gets.chomp.to_i

years.times do
  principal += principal * (1 / apr)
end

printf("The final value will be %.2f after #{years} years.\n", principal)
