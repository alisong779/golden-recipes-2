class Recipe < ApplicationRecord
  has_many :recipe_ingredients, inverse_of: :recipe
  has_many :ingredients, through: :recipe_ingredients
  has_many :directions
  belongs_to :user
  validates :title, :description, presence: true

  accepts_nested_attributes_for :directions,
                                reject_if: :all_blank,
                                allow_destroy: true
  accepts_nested_attributes_for :ingredients,
                                reject_if: :all_blank,
                                allow_destroy: true
accepts_nested_attributes_for :recipe_ingredients,
                                reject_if: :all_blank,
                               allow_destroy: true


  # def ingredient_attributes=(ingredient_attributes)
  #   ingredient_attributes.values.each do |ingredient_attribute|
  #     ingredient= Ingredient.find_or_create_by(ingredient_attribute)
  #     self.ingredients << ingredient
  #   end
  # end

  # def directions_attributes=(attributes)
  #   binding.pry
  #   attributes.values.each do |direction_attributes|
  #     direction= Direction.find_or_create_by(direction_attributes)
  #     self.directions << direction
  #   end
  # end
end
