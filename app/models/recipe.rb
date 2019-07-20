class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :directions
  belongs_to :user
  validates :title, :description, presence: true

  accepts_nested_attributes_for :directions,
                                reject_if: :all_blank,
                                allow_destroy: true
  accepts_nested_attributes_for :recipe_ingredients,
                                reject_if: :all_blank,
                                allow_destroy: true



end
