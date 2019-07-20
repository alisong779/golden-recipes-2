class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:user_id]
      @user = current_user
      @recipes = @user.recipes
    else
      @recipes = Recipe.all
    end
  end

  def show
    render 'show'
  end

  def new
    @recipe = Recipe.new
    2.times { @recipe.recipe_ingredients.build.build_ingredient }
    @direction = @recipe.directions.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe), notice: "Succesfully created new recipe"
    else
      2.times { @recipe.recipe_ingredients.build.build_ingredient }
      render 'new'
    end
  end

  def edit
    # @recipe_ingredient = RecipeIngredient.find(params[:id])
    # @ingredient = @recipe_ingredient.ingredient
  end

  def update
    # @recipe_ingredient = RecipeIngredient.find(params[:id])
    # @ingredient = @recipe_ingredient.ingredient
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Succesfully updated recipe"
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
