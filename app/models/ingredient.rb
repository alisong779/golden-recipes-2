class Ingredient < ApplicationRecord
  has_many :recipe_ingredients, inverse_of: :ingredient
  has_many :recipes, through: :recipe_ingredients

  accepts_nested_attributes_for :recipe_ingredients


  
end
