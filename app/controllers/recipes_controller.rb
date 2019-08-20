class RecipesController < ApplicationController
  before_action :find_recipe, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:user_id]
      @recipes = User.find(params[:user_id]).recipes
    else
      @recipes = Recipe.most_recent(3).title_length(5)
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new(user_id: params[:user_id])
    @ingredient = @recipe.ingredients.build
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
  end

  def update
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
                                  ingredients_attributes: [:id, :quantity, :unit, :name]
                                )
  end
end
