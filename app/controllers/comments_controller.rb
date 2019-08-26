class CommentsController < ApplicationController
	before_action :authenticate_user!, only: [:edit, :update, :destroy]
	skip_before_action :verify_authenticity_token


	def new
		@comment = @recipe.comments.build
	end
	#
	# def index
	# 	@comments = Comment.all
	# 	# render json: comments
	# end
	#
	# def show
	# 	@recipe = Recipe.find(params[:id])
	# 	# @comment = @recipe.comments.find(params[:id])
	# 	# render json: @comment
	# end
	#
	def create
		comment = @recipe.comments.build(comment_params)
		if comment.save
			render json: comment
		else
			render json: {errors: attraction.errors.full_messages}
		end
	end

	def show
		@comment = @recipe.comments.find_by(id: params[:id])
		render json: @comment
	end


	private

	def comment_params
		params.require(:comment).permit(:comment, :recipe_id)
	end
end
