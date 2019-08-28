class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :title, :recipe_id
  belongs_to :recipe
end
