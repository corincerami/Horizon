require "json"
require "pry"

# pulls movie data in from file
movie_data = JSON.parse(File.read("in_theaters.json"))
# converts individual movies in hash to an array
movies_array = movie_data["movies"]
# creates hash that will serve aas sorting mechanism for moviedata
sorted_hash = Hash.new

movies_array.each do |movie|
  # pulls critic score from ratings hash
  critics_score = movie["ratings"]["critics_score"]
  # pulls audience score from ratings hash
  audience_score = movie["ratings"]["audience_score"]
  average_score = (critics_score + audience_score) / 2
  movie_title = movie["title"]
  mpaa_rating = movie["mpaa_rating"]
  cast = movie["abridged_cast"]
  actors_array = []
  # extracts only name from "abridged_cast" hash (as opposed to character)
  cast.each do |actor|
    actors_array << actor["name"]
  end
  # organizes how data should be displayed, stores it all in one location
  movie_data_array = [average_score, movie_title, mpaa_rating, actors_array]
  # setting movie_data_array as the key, and average_score as the value
  sorted_hash[movie_data_array] = average_score

end

puts "In theaters now:"
sorted_hash.length.times do
  # finds key at the max value
  ind_movie = sorted_hash.key(sorted_hash.values.max)
  print "#{ind_movie[0]} - #{ind_movie[1]} (#{ind_movie[2]}) starring "
  # (ACTORS MECHANISM) pulls out each individual actor for printing
  (0..ind_movie[3].length - 2).each do |i|
    print ind_movie[3][i] + ", "
  end
  # prints out the last actor
  puts ind_movie[3][-1]
  # once printed, removes max key in order to have new max
  sorted_hash.delete(ind_movie)
end
