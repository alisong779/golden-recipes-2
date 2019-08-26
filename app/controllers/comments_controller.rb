class CommentsController < ApplicationController
	# before_action :authenticate_user!, only: [:edit, :update, :destroy]
	before_action :set_recipe, only: [:index, :create]
	# skip_before_action :verify_authenticity_token

	def index

	end

	def new
		@comment = @recipe.comments.build
	end

	def show
		@comment = @recipe.comments.find_by(id: params[:id])
		render json: @comment
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
		params.require(:comment).permit(:comment, :recipe_id)
	end
end
