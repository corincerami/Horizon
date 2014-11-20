require "sinatra"
require "pry"
require "sinatra/reloader"
require "csv"
require "uri"

enable :sessions

SITE_TITLE = "Sick Sad World"
SITE_DESCRIPTION = "News to Waste Your Time"

def collect_articles
  articles = {}
  CSV.foreach("news.csv", headers: true) do |row|
    articles[row["title"]] = [
    row["url"], row["description"]]
  end
  articles
end

get "/" do
  redirect "/articles"
end

get "/articles" do
  @articles = collect_articles
  erb :articles
end

get "/articles/new" do
  erb :new_article
end

def valid?(url)
  !!URI.parse(url)
end

def check_form_data(title, url, description)
  error_messages = Array.new
  error_messages << "All fields must be completed" if title == "" || url == "" || description == ""
  error_messages << "Description must be at least 20 characters" if description.length < 20
  articles = collect_articles
  articles.each do |title, stuff|
    if stuff[0] == url
      error_messages << "That URL has already been submitted"
    end
  end
  error_messages << "You must enter a valid URL" if valid?(url)
  error_messages
end

post "/articles" do
  @title = params[:title]
  @url = params[:url]
  @description = params[:description]
  error_messages = check_form_data(@title, @url, @description)
  if !error_messages.empty?
    @error_messages = error_messages
    erb :new_article
  else
    CSV.open("news.csv", "a") do |csv|
      csv << [@title, @url, @description]
    end
    redirect "/articles"
  end
end
