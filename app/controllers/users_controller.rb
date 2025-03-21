class UsersController < ApplicationController
    before_action :authorized
    before_action :set_user, only: [:show, :update, :destroy]

    def show
        render json: @user  
    end

    def update
        if @user.update(user_params)
            render json: @user
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        @user.destroy
        render json: { message: "User deleted successfully" }
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user)
            .permit(:username, :email, :password, :password_confirmation, :bio,
                    :image)
    end
end
