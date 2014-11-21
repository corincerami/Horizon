require "sinatra"
require "sinatra/reloader"

get "/" do
  redirect "/groceries"
end

get "/groceries" do
  @title = "Grocery List"
  @groceries = File.read("grocery_list.txt").split("\n")
  erb :"groceries/index"
end

post "/groceries" do
  new_item = params[:new_item]
  File.open("grocery_list.txt", "a") do |f|
    f.write("#{new_item}\n")
  end
  redirect "/groceries"
end
