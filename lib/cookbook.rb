require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(index_recipe)
    @recipes.delete_at(index_recipe)
    save_csv
  end

  def find(index_recipe)
    @recipes[index_recipe]
  end

  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      name = row[0] # String
      description = row[1] # String
      rating = row[2].to_i
      done = row[3] == 'true'
      prep_time = row[4]
      @recipes << Recipe.new(name, description, rating, prep_time, done)
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name,
                recipe.description,
                recipe.rating,
                recipe.done?,
                recipe.prep_time]
      end
    end
  end
end