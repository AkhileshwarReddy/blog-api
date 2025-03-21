class FollowsController < ApplicationController
    before_action :authorized

    def create
        user = User.find(params[:user_id])
        if current_user.following.include?(user)
            render json: { error: 'You are already following this user' }, status: :unprocessable_entity
        else
            current_user.following << user
            render json: { message: 'Followed successfully.' }, status: :created
        end
    end

    def destroy
        user = User.find(params[:user_id])
        if current_user.following.include?(user)
            current_user.following.delete(user)
            render json: { message: 'Unfollowed successfully.' }, status: :ok
        else
            render json: { error: 'You are not following this user' }, status: :unprocessable_entity
        end
    end

    def followers
        followers = current_user.followers
        render json: followers
    end

    def following
        following = current_user.following
        render json: following
    end
end
