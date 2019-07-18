class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]
  #
  # def index
  #   if params[:recipe_id]
  #     @ingredients = Recipe.find(params[:recipe_id]).ingredients
  #   else
  #     @ingredients = Ingredient.all
  #   end
  # end
  #
  # def show
  # end
  #
  # def new
  #   if params[:recipe_id]
  #     @recipe = Recipe.find(params[:recipe_id])
  #     @recipe_ingredient = @recipe.recipe_ingredients.build
  #     @ingredient = @recipe_ingredient.build_ingredient
  #   else
  #     @ingredient = Ingredient.new
  #   end
  # end
  #
  # def edit
  # end
  #
  # def create
  #   if ingredient_params[:recipe_id]
  #     @recipe = Recipe.find(ingredient_params[:recipe_id])
  #     @ingredient = Ingredient.find_or_create_by(name: ingredient_params[:name])
  #     @recipe.recipe_ingredients.build(:ingredient_id => @ingredient.id,
  #                                       :quantity => ingredient_params[:recipe_ingredient][:quantity],
  #                                       :unit => ingredient_params[:recipe_ingredient][:unit])
  #     if @recipe.save!
  #       redirect_to recipe_path(@recipe)
  #     else
  #     redirect_to new_recipe_ingredient_path(@recipe)
  #     end
  #   else
  #     @ingredient = Ingredient.create(ingredient_params)
  #     if @ingredient.save
  #       redirect_to ingredients_path
  #     else
  #       render 'new'
  #     end
  #   end
  # end
  #
  # def update
  #   if @ingredient.update(ingredient_params)
  #     redirect_to @ingredient, notice: 'Ingredient was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end
  #
  # def destroy
  #   @ingredient.destroy
  #     redirect_to ingredients_url, notice: 'Ingredient was successfully destroyed.'
  # end
  #
  #
  # private
  #   def set_ingredient
  #     @ingredient = Ingredient.find(params[:id])
  #   end
  #
  #   def ingredient_params
  #     params.require(:ingredient).permit(:name, :recipe_id, recipe_ingredient: [:quantity, :unit])
  #   end
end
