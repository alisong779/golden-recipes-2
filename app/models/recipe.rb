class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :directions
  belongs_to :user


  accepts_nested_attributes_for :directions,
                                reject_if: :all_blank,
                                allow_destroy: true
  accepts_nested_attributes_for :ingredients,
                                reject_if: :all_blank,
                                allow_destroy: true
accepts_nested_attributes_for :recipe_ingredients,
                               reject_if: :all_blank,
                               allow_destroy: true
  validates :title, :description, :avatar, presence: true
  has_one_attached :avatar

end
