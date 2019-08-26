class Recipe < ApplicationRecord
  has_many :ingredients
  has_many :directions
  has_many :comments
  belongs_to :user
  validates :title, :description, presence: true
  scope :most_recent, -> (limit) {order("created_at desc").limit(limit)}
  scope :title_length, -> (n = 10) {where("LENGTH(title) > ?", n)}
  has_one_attached :image

  accepts_nested_attributes_for :directions,
                                allow_destroy: true
  accepts_nested_attributes_for :ingredients,
                                allow_destroy: true
  accepts_nested_attributes_for :comments,
                                allow_destroy: true



end
