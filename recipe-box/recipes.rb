# * Visiting `/recipes` lists the names of all of the recipes in the database, sorted alphabetically.
# * Each name is a link that takes you to the recipe details page (e.g. `/recipes/1`)
# * Visiting `/recipes/:id` will show the details for a recipe with the given ID.
# * The page must include the recipe name, description, and instructions.
# * The page must list the ingredients required for the recipe.

require "sinatra"
require "sinatra/reloader"
require "pg"
require "pry"

def db_connection
  begin
    connection = PG.connect(dbname: 'recipes')

    yield(connection)
  ensure
    connection.close
  end
end

get "/" do
  redirect "/recipes"
end

get "/recipes" do
  query = "SELECT * FROM recipes"
  @recipes = db_connection { |conn| conn.exec(query) }.to_a
  erb :index
end

get "/recipes/:id" do
  recipe_id = params[:id]
  query = "SELECT recipes.name AS recipe, recipes.description,
           recipes.instructions, ingredients.name AS ingredients
           FROM recipes
           JOIN ingredients ON ingredients.recipe_id = recipes.id
           WHERE recipes.id = $1"
  @recipe_info = db_connection { |conn| conn.exec(query, [recipe_id]) }.to_a
  erb :show
end
