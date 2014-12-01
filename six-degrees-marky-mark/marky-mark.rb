#!/usr/bin/env ruby
require "pg"
require "pry"

if ARGV.length != 1
  puts "usage: #{__FILE__} \"<actor name>\""
  exit(1)
end

target_actor = ARGV[0]

def db_connection
  begin
    connection = PG.connect(dbname: 'movies')

    yield(connection)
  ensure
    connection.close
  end
end

def select_from_db(query)
  result = db_connection do |conn|
    conn.exec(query)
  end
  result.to_a
end

@open_routes = []
@closed_routes = []

start_query = "SELECT actors.id, cast_members.movie_id
              FROM actors
              LEFT OUTER JOIN cast_members ON cast_members.actor_id = actors.id
              LEFT OUTER JOIN movies ON cast_members.movie_id = movies.id
              WHERE actors.id = 1841;"

marky_mark_movies = select_from_db(start_query)

target_actor_query = "SELECT actors.id FROM actors
                   WHERE actors.name = '#{target_actor}';"

target_actor_id = select_from_db(target_actor_query)[0]["id"]

def check_actors_from_movies(movie, target_actor_id)
    if actor == target_actor_id
      @closed_routes << cast_hash
    else
      @open_routes << cast_hash unless @open_routes.include?(cast_hash)
    end
  end
end

# finds all movies Mark Wahlberg has starred in
marky_mark_movies.each do |hash|
  result = []
  query = "SELECT DISTINCT actors.id, cast_members.movie_id
           FROM actors
           LEFT OUTER JOIN cast_members ON cast_members.actor_id = actors.id
           WHERE cast_members.movie_id = #{hash["movie_id"]};"
  result = select_from_db(query)
  check_actors_from_movies(result.uniq, target_actor_id)
end

def check_movies_for_actors(target_actor_id)
  cast_hash = @open_routes[0]
  query = "SELECT DISTINCT actors.id, cast_members.movie_id
           FROM actors
           LEFT OUTER JOIN cast_members ON cast_members.actor_id = actors.id
           WHERE movie_id = #{cast_hash['movie_id']}"
   actors = select_from_db(query)
   check_actors_from_movies(actors[0]["movie_id"], target_actor_id)
   binding.pry
end

until @closed_routes.length > 0
  check_movies_for_actors(target_actor_id)
  @open_routes.shift
  puts @open_routes[0]
end

puts @closed_routes
