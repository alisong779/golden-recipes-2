class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:user_id]
      @recipes = User.find(params[:user_id]).recipes
      # @user = current_user
      # @recipes = @user.recipes
    else
      @recipes = Recipe.most_recent(3).title_length(5)
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new(user_id: params[:user_id])
    3.times {@recipe.recipe_ingredients.build.build_ingredient}
    @direction = @recipe.directions.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe)
      flash[:success] = "Recipe Sucessfully Created!"
    else
      render 'new'
    end
  end

  def edit
    if !authorized_to_edit?(@recipe)
      redirect_to recipes_path
      flash[:alert]= "You cant edit that recipe!"
    end
    # @recipe_ingredient = RecipeIngredient.find(params[:id])
    # @ingredient = @recipe_ingredient.ingredient
  end

  def update
    # @recipe_ingredient = RecipeIngredient.find(params[:id])
    # @ingredient = @recipe_ingredient.ingredient
    if !authorized_to_edit?(@recipe)
      redirect to recipes_path
      flash[:alert]= "You cant edit that recipe!"
    end
    if @recipe.update(recipe_params)
      redirect_to @recipe
      flash[:success] = "Sucessfully Update Recipe!"
    else
      render 'edit'
    end
  end

  def destroy
      @recipe.destroy
      redirect_to root_path
      flash[:success] = "Succesfully deleted recipe!"
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end


  def recipe_params
    params.require(:recipe).permit(:title, :description, :image,
                                  directions_attributes: [:id, :step],
                                  recipe_ingredients_attributes: [:id, :ingredient_id, :recipe_id, :quantity, :unit,
                                  ingredient_attributes: [:id, :name]
                                ]
                                )
  end
end
