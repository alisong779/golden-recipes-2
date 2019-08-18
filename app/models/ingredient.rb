class Ingredient < ApplicationRecord
  belongs_to :recipe
  validates :name, :quantity, :unit, presence: true
end
