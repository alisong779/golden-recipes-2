class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :comment_id
  has_many :comments
end
