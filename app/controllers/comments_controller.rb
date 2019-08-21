class CommentsController < ApplicationController
	before_action :find_comment, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, only: [:edit, :update, :destroy]

	def index
		comments = Comment.all
		render json: comments
	end

	def show
		binding.pry
		comment = Comment.find_by_id(params[:id])
		render json: comment
	end

	def create
		binding.pry
		comment = Comment.new(comment_params)
		if comment.save
			render json: comment, status: 201
		else
			render json: {errors: comment.errors.full_messages}, status: :bad_request
		end
	end


	private

	def comment_params
		params.require(:comment).permit(:comment, :user_id, :recipe_id)
	end
end 
