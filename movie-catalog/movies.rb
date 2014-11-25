require "sinatra"
require "sinatra/reloader"
require "csv"
require "pry"

SITE_TITLE = "Movie Catalog"

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

def search(all_movies, search_term)
  matching_movies = []
  all_movies.each do |movie|
    if movie[1][:title].downcase.include?(search_term.downcase) ||
        movie[1][:synopsis].to_s.downcase.include?(search_term.downcase)
      matching_movies << movie
    end
  end
  matching_movies
end

get "/" do
  redirect "/movies"
end

get "/movies/?" do
  @movies = collect_movies
  if params[:search]
    @movies = search(@movies, params[:search])
  end
  @page = params[:page].to_i
  erb :"movies/index"
end

get "/movies/:id" do
  @id = params[:id]
  all_movies = collect_movies
  @movie = all_movies[params[:id]]
  erb :"movies/show"
end
