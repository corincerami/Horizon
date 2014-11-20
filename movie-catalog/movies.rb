require "sinatra"
require "sinatra/reloader"
require "csv"
require "pry"

def collect_movies
  all_movies = Hash.new
  CSV.foreach("movies.csv", headers: true) do |row|
    movie = Hash.new
    movie[:title] = row["title"]
    movie[:year] = row["year"]
    movie[:synopsis] = row["synopsis"]
    movie[:rating] = row["rating"]
    movie[:genre] = row["genre"]
    movie[:studio] = row["studio"]
    movie[:id] = row["id"]
    all_movies[row["id"]] = movie
  end
  all_movies
end

get "/" do
  redirect "/movies"
end

get "/movies/?" do
  @movies = collect_movies
  @page = params[:page].to_i
  erb :"movies/index"
end

get "/movies/:id" do
  @id = params[:id]
  all_movies = collect_movies
  @movie = all_movies[params[:id]]
  erb :"movies/show"
end
