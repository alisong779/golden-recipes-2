class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  validates :quantity, :unit, presence: true


  # def ingredient_attributes=(ingredient_attributes)
  #   ingredient_attributes.values.each do |attribute|
  #     if attribute != ""
  #       new_ingredient = Ingredient.find_or_create_by(name: attribute)
  #       self.ingredient = new_ingredient
  #     end
  #   end
  # end
end
