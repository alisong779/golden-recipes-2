class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  validates :quantity, :unit, presence: true

  accepts_nested_attributes_for :ingredient,
                                reject_if: :all_blank,
                                allow_destroy: true


end
