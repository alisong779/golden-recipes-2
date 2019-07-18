class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @recipe = Recipe.all
  end

  def show
    render 'show'
  end

  def new
    @recipe = Recipe.new
    @recipe_ingredient = @recipe.recipe_ingredients.build
    @direction = @recipe.directions.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: "Succesfully created new recipe"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path, notice: "Succesfully deleted recipe"
  end

  private



  def recipe_params
    params.require(:recipe).permit(:title, :description,
                                  directions_attributes: [:id, :step],
                                  recipe_ingredients_attributes: [:id, :ingredient_id, :recipe_id, :quantity, :unit,
                                  ingredient_attributes: [:id, :name]
                                ]
                                )
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end
end
