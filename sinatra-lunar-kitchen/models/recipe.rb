class Recipe
  attr_reader :name, :id, :instructions, :ingredients, :description

  def initialize(name, id, instructions, ingredients, description)
    @name = name
    @id = id
    @instructions = instructions
    @ingredients = ingredients
    @description = description
  end

  def self.all
    query = "SELECT DISTINCT name, id, instructions, description
             FROM recipes ORDER BY recipes.name;"
    recipes = DBConnection.connect("recipes") { |conn| conn.exec(query) }
    collection = []
    recipes.each do |recipe|
      collection << Recipe.new(recipe['name'], recipe['id'],
                               recipe['instructions'], recipe['ingredient'],
                               recipe['description'])
    end
    collection
  end

  def self.find(id)
    query = "SELECT name, description, instructions
             FROM recipes WHERE recipes.id = $1"
    recipe = DBConnection.connect("recipes") { |conn| conn.exec(query, [id]) }[0]
    ingredients_query = "SELECT * FROM ingredients
                         WHERE recipe_id = $1"
    ingredients = DBConnection.connect("recipes") { |conn| conn.exec(ingredients_query, [id]) }
    Recipe.new(recipe['name'], recipe['id'], recipe['instructions'],
               ingredients, recipe['description'])
  end
end
