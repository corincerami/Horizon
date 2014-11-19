require "sinatra"
require "pry"
require "sinatra/reloader"
require "csv"
require "sinatra/flash"
require "sinatra/redirect_with_flash"

enable :sessions

SITE_TITLE = "Sick Sad World"
SITE_DESCRIPTION = "News to Waste Your Time"

articles = {}

get "/" do
  redirect "/articles"
end

get "/articles" do
  CSV.foreach("news.csv", headers: true) do |row|
    articles[row["title"]] = [
    row["url"], row["description"]]
  end
  @articles = articles
  erb :articles
end

get "/articles/new" do
  erb :new_article
end

def check_form_data(title, url, description)
  error_messages = Array.new
  error_messages << "All fields must be completed" if title == "" || url == "" || description == ""
  error_messages << "Description must be at least 20 characters" if description.length < 20
  #error_messages << "URL has already been submitted" if
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
