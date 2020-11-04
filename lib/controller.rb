require_relative 'view'
require_relative 'scrape_allrecipes_service'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # Pegar todas as receitas do cookbook
    recipes = @cookbook.all
    # Mandar para a view exibir
    @view.display(recipes)
  end

  def create
    # Perguntar o nome da receita
    name = @view.ask_recipe_name
    # Perguntar a descricao da receita
    description = @view.ask_recipe_description
    # Perguntar a nota receita
    rating = @view.ask_recipe_rating
    # Perguntar o tempo de preparo
    prep_time = @view.ask_prep_time
    # Instaciar uma nova receita
    new_recipe = Recipe.new(name, description, rating, prep_time)
    # Adicionar a receita ao cookbook
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    # Listar as receitas
    list
    # Perguntar o index da receita para excluir
    index = @view.ask_index
    # Remover do cookbook a receita pelo index
    @cookbook.remove_recipe(index)
  end

  def mark_as_done
    # Listar todas as receitas
    list
    # Pergutar o index da receita para marcar como done
    index = @view.ask_index
    # Achar a receita no cookbok pelo index
    recipe = @cookbook.find(index)
    # Marcar a receita como done
    recipe.done!
    # Salvar no cookbook
    @cookbook.save_csv
  end

  def import
    ingredient = @view.ask_ingredient
    service = ScrapeAllrecipesService.new(ingredient)
    @cookbook.add_recipe(service.call)

  end


end
