require 'sinatra'
require 'pry'
require 'sinatra/reloader'
require 'pg'

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


get "/" do
  erb :home
end

get "/actors" do
  query = 'SELECT * FROM actors;'
  @actors = select_from_db(query)
  erb :'actors/index'
end

get "/actors/:id" do
  actor_name = params[:id]
  query = 'SELECT movies.title, cast_members.character, actors.name
           FROM actors
           JOIN cast_members ON actors.id = cast_members.actor_id
           JOIN movies ON movies.id = cast_members.movie_id
           WHERE actors.name = "#{actor_name}";'
  @actor_info = select_from_db(query)
  erb :'actors/show'
end

get "/movies" do
  query = 'SELECT * FROM movies;'
  @movies = select_from_db(query)
  erb :'movies/index'
end

get "/movies/:id" do
  movie_title = params[:id]
  query = ''
  erb :'movies/show'
end


# * Visiting `/actors/:id` will show the details for a given actor. This page should contain a list of movies
# that the actor has starred in and what their role was. Each movie should link to the details page for that movie.

# * Visiting `/movies/:id` will show the details for the movie. This page should contain information about the movie
# (including genre and studio) as well as a list of all of the actors and their roles. Each actor name is a link to
# the details page for that actor.
