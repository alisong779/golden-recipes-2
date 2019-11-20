class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :user_id
  has_many :comments
end
