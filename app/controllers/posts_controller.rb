class PostsController < ApplicationController
    before_action :authorized
    before_action :set_post, only: [:show, :update, :destroy]
    before_action :correct_user, only: [:update, :destroy]

    def index
        posts = Post.where(status: 'pubished')
        render json: posts, include: [:user, :tags]
    end

    def show
        render json: @post, include: [:user, :tags]
    end

    def create
        post = current_user.posts.build(post_params)

        if post.save
            update_tags(post)
            notify_followers(post)
            render json: post, include: :tags, status: :created
        else
            render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        if @post.update(post_params)
            update_tags(@post)
            render json: @post, include: :tags
        else
            render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        @post.destroy
        render json: { message: 'Post deleted successfully.'}
    end

    private

    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post)
            .permit(:title, :body, :status, :video, :status)
    end

    def update_tags(post)
        post.tags = params[:post][:tag_names].map do |tag|
            Tag.find_or_create_by(name: tag)
        end
    end

    def correct_user
        render json: { message: 'Not authorized' }, status: :unauthorized unless @post.user == current_user
    end

    def notify_followers(post)
        current_user.followers.each do |follower|
            NotificationMailer.new_post_notification(follower, post).deliver_now
        end
    end
end
