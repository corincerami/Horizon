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
  actor_id = params[:id]
  query = "SELECT movies.title, movies.id, cast_members.character, actors.name
           FROM actors
           LEFT OUTER JOIN cast_members ON actors.id = cast_members.actor_id
           LEFT OUTER JOIN movies ON movies.id = cast_members.movie_id
           WHERE actors.id = '#{actor_id}';"
  @actor_info = select_from_db(query)
  erb :'actors/show'
end

get "/movies" do
  query = 'SELECT * FROM movies;'
  @movies = select_from_db(query)
  @sort_choice = params[:order]
  erb :'movies/index'
end

get "/movies/:id" do
  movie_id = params[:id]
  query = "SELECT genres.name AS genre, studios.name AS studio,
           actors.name AS actor, actors.id AS actor_id, cast_members.character, movies.title AS title
           FROM movies
           JOIN cast_members ON movies.id = cast_members.movie_id
           JOIN actors ON actors.id = cast_members.actor_id
           JOIN genres ON genres.id = movies.genre_id
           LEFT OUTER JOIN studios ON studios.id = movies.studio_id
           WHERE movies.id = '#{movie_id}';"
  @movie_info = select_from_db(query)
  erb :'movies/show'
end
