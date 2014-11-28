require 'sinatra'
require 'pry'
require 'sinatra/reloader'
require 'pg'

# duplicate actors appearing on index page

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

def page_finder
  @page = params[:page]
  if @page.to_i < 1
    @page = 1
  else
    # sanitizes page input
    @page = @page.to_i
  end
  page_offset = (@page - 1)* 20
end

get "/" do
  erb :home
end

get "/actors" do
  @search = params[:query]
  page_offset = page_finder
  @last_page = select_from_db("SELECT * FROM actors;").length / 20
  if @search
    query = "SELECT actors.name, actors.id FROM actors
             LEFT OUTER JOIN cast_members
             ON cast_members.actor_id = actors.id
             WHERE actors.name ILIKE '%#{@search}%' OR
             cast_members.character ILIKE '%#{@search}%'
             ORDER BY actors.name
             OFFSET #{page_offset} LIMIT 20;"
  else
    query = "SELECT actors.name, actors.id FROM actors
             ORDER BY actors.name
             OFFSET #{page_offset} LIMIT 20;"
  end
  @actors = select_from_db(query).to_a
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
  #ensures that sort order isn't vulnerable to SQL injection
  if params[:order] == "title" || params[:order] == "year" || params[:order] == "rating"
    @sort_choice = params[:order]
  else
    @sort_choice = "title"
  end
  page_offset = page_finder
  # need to figure out a good solution for finding the last page to be displayed
  # @last_page = (.length.to_f / 20).ceil
  @last_page = select_from_db("SELECT * FROM movies;").length / 20
  # ****
  # SEARCH IS STILL VULNERABLE TO SQL INJECTION
  # ***
  @search = params[:query]
  if @search
    query = "SELECT movies.title, movies.id, movies.year, movies.rating,
             genres.name AS genre, studios.name AS studio
             FROM movies
             LEFT OUTER JOIN genres ON genres.id = movies.genre_id
             LEFT OUTER JOIN studios ON studios.id = movies.studio_id
             WHERE title LIKE '%#{@search}%' OR synopsis ILIKE '%#{@search}%'
             ORDER BY #{@sort_choice}
             OFFSET #{page_offset} LIMIT 20;"
  else
    query = "SELECT movies.title, movies.id, movies.year, movies.rating,
             genres.name AS genre, studios.name AS studio
             FROM movies
             LEFT OUTER JOIN genres ON genres.id = movies.genre_id
             LEFT OUTER JOIN studios ON studios.id = movies.studio_id
             ORDER BY #{@sort_choice}
             OFFSET #{page_offset} LIMIT 20;"
  end
  @movies = select_from_db(query)
  erb :'movies/index'
end

get "/movies/:id" do
  movie_id = params[:id]
  query = "SELECT genres.name AS genre, studios.name AS studio,
           actors.name AS actor, actors.id AS actor_id, cast_members.character, movies.title AS title
           FROM movies
           LEFT OUTER JOIN cast_members ON movies.id = cast_members.movie_id
           LEFT OUTER JOIN actors ON actors.id = cast_members.actor_id
           LEFT OUTER JOIN genres ON genres.id = movies.genre_id
           LEFT OUTER JOIN studios ON studios.id = movies.studio_id
           WHERE movies.id = '#{movie_id}';"
  @movie_info = select_from_db(query)
  erb :'movies/show'
end
