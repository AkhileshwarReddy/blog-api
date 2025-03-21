class CommentsController < ApplicationController
    before_action :authorized
    before_action :set_commentable
    before_action :set_comment, only: [:destroy]
    before_action :correct_user, only: [:destroy]
    
    def create
        comment = @commentable.comments.build(comment_params)
        comment.user = current_user

        if comment.save
            render json: comment, status: :created
        else
            render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def index
        comments = @commentable.comments
        render json: comments, include: :user
    end

    def destroy
        @comment.destroy
        render json: { message: 'Comment deleted successfully.' }
    end

    private

    def set_commentable
        @commentable = if params[:post_id]
            Post.find(params[:post_id])
        elsif params[:comment_id]
            Comment.find(params[:comment_id])
        end
    end

    def set_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:body)
    end

    def correct_user
        render json: { error: 'You are not authorized to perform this action.' }, status: :unauthorized unless @comment.user == current_user
    end
end
