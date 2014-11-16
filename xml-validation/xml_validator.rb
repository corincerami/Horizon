input = ARGV[0]

def check_tags(input)
  # finds all tags in the xml file bei
  all_tags = File.read(input).scan(/<\/*\w+\s{0,1}\w*\=*\"*\w*\"*>/)
  # creates an array to use as a stack
  tags_stack = Array.new
  all_tags.each do |tag|
    # tag_index = tags_stack.index(tag)
    if tag[1] == "/"
      tag.slice!(1) # remove / character
      tag.slice!(-1) # remove > character
      # if last tag in stack matches closing tag, delete it
      if tags_stack[-1].start_with?(tag) # closing tag matches last open tag
        tags_stack.pop # delete last tag in the stack
      end
    else
      tags_stack << tag # add open tag to the stack
    end
  end
  tags_stack.empty?
end

#check for one and only one root element
def check_root(input)
  root = File.read(input).scan(/<\?\w+\sversion=/)
  root.length == 1
end

# if the stack is empty, all tags were closed in the right order, else invalid
check_tags(input) && check_root(input) ? puts("VALID") : puts("INVALID")
