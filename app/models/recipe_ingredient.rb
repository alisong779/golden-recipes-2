class RecipeIngredient < ApplicationRecord
  belongs_to :recipe, optional: true
  belongs_to :ingredient, optional: true 
  validates :quantity, :unit, presence: true

  accepts_nested_attributes_for :ingredient,
                                reject_if: :all_blank,
                                allow_destroy: true


end
