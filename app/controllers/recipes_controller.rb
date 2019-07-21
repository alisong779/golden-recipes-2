class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def most_recent
    @recipes = Recipe.most_recent
    render action :index
  end

  def recipe_length
    @recipes = Recipe.title_length
    render action :index
  end

  def index
    if params[:user_id]
      @user = current_user
      @recipes = @user.recipes
    else
      @recipes = Recipe.all
    end
  end

  def show

  end

  def new
    @recipe = Recipe.new
    @recipe.recipe_ingredients.build.build_ingredient
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
