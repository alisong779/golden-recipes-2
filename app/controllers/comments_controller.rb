class CommentsController < ApplicationController
	before_action :set_comment, only: [:show, :edit, :update]

	def index
		@comments = Comment.all
		respond_to do |format|
			format.html
			format.json {render json: @comments}
	end

	def show
		@comment = Comment.find_by_id(params[:id])
		render json: @comment
	end

	def create
		@comment = Comment.new(comment_params)
		if @comment.save
    	render json: @comment, status: 201
		else
			render json: {errors: @comment.errors.full_messages}, status: :bad_request
		end
	end


	private
	def set_comment
    @comment = Comment.find(params[:id])
  end

	def comment_params
    params.require(:comment).permit(:comment, :user_id, :recipe_id)
  end

end
