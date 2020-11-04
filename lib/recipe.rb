class Recipe
  attr_reader :name, :description, :rating, :prep_time

  def initialize(name, description, rating, prep_time, done = false)
    @name = name
    @description = description
    @rating = rating
    @done = done
    @prep_time = prep_time
  end

  def done?
    @done
  end

  def done!
    @done = true
  end

  # Métodos gerados pelo attr_reader:
  # def name
  #   @name
  # end

  # def description
  #   @description
  # end
end

# recipe = Recipe.new('feijoada', 'carne de porco e arroz')


