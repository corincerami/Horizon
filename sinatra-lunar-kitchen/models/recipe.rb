def db_connection
  begin
    connection = PG.connect(dbname: 'recipes')

    yield(connection)
  ensure
    connection.close
  end
end

class Recipe
  def initialize(name, id, instructions, ingredients, description)
    @name = name
    @id = id
    @instructions = instructions
    @ingredients = ingredients
    @description = description
  end

  def self.all
    query =
      "SELECT DISTINCT
        recipes.name AS recipe_name,
        recipes.id AS id,
        recipes.instructions AS instructions,
        recipes.description AS description
      FROM
        recipes
      ORDER BY
        recipes.name;"
    recipes = db_connection { |conn| conn.exec(query) }
    collection = []
    recipes.each do |recipe|
      collection << Recipe.new(recipe['recipe_name'], recipe['id'],
                               recipe['instructions'], recipe['ingredient'],
                               recipe['description'])
    end

    collection
  end

  def self.find(id)
    query = "SELECT recipes.name AS recipe, recipes.description,
           recipes.instructions
           FROM recipes
           WHERE recipes.id = $1"
    recipe = db_connection { |conn| conn.exec(query, [id]) }[0]
    ingredients_query = "SELECT * FROM ingredients
                         WHERE recipe_id = $1"
    ingredients = db_connection { |conn| conn.exec(ingredients_query, [id]) }
    Recipe.new(recipe['recipe'], recipe['id'], recipe['instructions'],
               ingredients, recipe['description'])
  end

  attr_reader :name, :id, :instructions, :ingredients, :description
end
