class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :recipe_id
  belongs_to :recipe
end
