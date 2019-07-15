class Recipe < ApplicationRecord
  has_many :ingredients
  has_many :directions
  has_many :comments
  has_many :users, through :comments
  accepts_nested_attributes_for :directions,
                                reject_if: proc { |attributes| attributes['name'].blank?},
                                allow_destroy: true
  accepts_nested_attributes_for :ingredients,
                                reject_if: proc { |attributes| attributes['name'].blank?},
                                allow_destroy: true
  validates :title, :description, :avatar, presence: true                        
  has_one_attached :avatar

end
