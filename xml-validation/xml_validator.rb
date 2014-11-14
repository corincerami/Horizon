require "pry"

input = ARGV[0]

# checks for missing tags, ignores self-closing tags
# doesn't account for tags in the wrong order
open_tags = File.read(input).scan(/<\w+>/)
close_tags = File.read(input).scan(/<\/\w+>/)

open_tags.each do |tag|
  if close_tags.include?(tag.insert(1, "/"))
    open_tags.delete_at(open_tags.index(tag))
    close_tags.delete_at(close_tags.index(tag))
  else
    puts "INVALID"
    exit
  end
end

# checks for root element

puts "VALID"
