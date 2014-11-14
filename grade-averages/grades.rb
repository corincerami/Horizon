require "json"
require "pry"

grades = JSON.parse(File.read("students.json"))

grades["students"].each do |student|
  total = student["grades"].reduce(:+)
  avg = (total.to_f / student["grades"].length)
  avg = sprintf('%.2f', avg)
  max = student["grades"].max
  min = student["grades"].min
  puts "#{student["name"]}".ljust(8) +
  "#{avg}".rjust(8) + "#{max}".rjust(8) +
  "#{min}".rjust(8)
end
