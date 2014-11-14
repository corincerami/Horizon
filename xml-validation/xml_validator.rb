# check for opening items using scan or regex
# store opening items in an array
# check for closing items using scan or regex
# each closing item should correspond with the last opening item in the array
# if a correponding opening item exists for the closing item, remove it from array
# if array is empty at the end, all items are closed
# make an exception for self-closing items and doctype items
# only one root element (doctype element?) should exist

input = ARGV[0]
open_items = File.read(input).scan(/<\w+>/)
binding.pry
