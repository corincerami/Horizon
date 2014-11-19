require "sinatra"
require "sinatra/reloader"
require "json"
require "pry"
require "sinatra/flash"
require "sinatra/redirect_with_flash"

enable :sessions

file = File.read("roster.json")
roster = JSON.parse(file)

teams = Hash.new
team_array = Array.new

roster.each do |k, v|
  team_hash = Hash.new
  team_hash["name"] = k
  team_hash["players"] = v
  teams[k.downcase.gsub(" ", "-")] = team_hash
  team_array << team_hash
end

teams["griffin-goats"]["img"] = "goat_mascot.jpg"
teams["simpson-slammers"]["img"] = "pog-slammers.jpg"
teams["flintstone-fire"]["img"] = "fire.gif"
teams["jetson-jets"]["img"] = "jet.gif"

get "/" do
  @teams = teams
  erb :home
end

get "/:team" do
  @url = params[:team]
  @teams = teams
  if @teams[@url] == nil
    redirect "/", flash[:error] = "That team doesn't exist."
  else
    erb :teams
  end
end

get "/position/:position" do
  @position = params[:position]
  @teams = team_array
  erb :position
end
