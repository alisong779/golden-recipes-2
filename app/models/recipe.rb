class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :directions
  belongs_to :user
  validates :title, :description, presence: true
  scope :most_recent, -> (limit) {order("created_at desc").limit(limit)}
  scope :title_length, -> (n = 10) {where("LENGTH(title) > ?", n)}

  accepts_nested_attributes_for :directions,
                                allow_destroy: true
  accepts_nested_attributes_for :recipe_ingredients,
                                allow_destroy: true



end
