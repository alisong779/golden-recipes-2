class CommentsController < ApplicationController
	# before_action :authenticate_user!, only: [:edit, :update, :destroy]
	before_action :set_recipe, only: [:index, :create]

	def index
		comments = Recipe.find(params[:recipe_id]).comments
		render json: comments
	end

	def new
		@comment = @recipe.comments.build
	end

	def show
		comment = Comment.find_by_id(params[:id])
		render json: comment
	end

	def create
		@comment = @recipe.comments.build(comment_params)
		if @comment.save
			render json: @comment
		else
			render json: {errors: @comment.errors.full_messages}
		end
	end


	private

	def set_recipe
		@recipe = Recipe.find(params[:recipe_id])
	end


	def comment_params
		params.require(:comment).permit(:title, :comment, :recipe_id)
	end
end
