class AuthController < ApplicationController
    skip_before_action :authorized, only: [:login, :register, :confirm]
    
    def register
        user = User.new(user_params)

        if user.save
            UserMailer.confirmation_email(user).deliver
            token = encode_token({user_id: user.id})
            render json: {user: user, token: token}, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def login
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
            token = encode_token({user_id: user.id})
            render json: {user: user, token: token}
        else
            render json: {error: "Invalid email or password"}, status: :unauthorized
        end
    end

    def confirm
        user = User.find_by(confirmation_token: params[:token])
        if user
            user.confirm!
            render json: { message: 'Your account has been confirmed.' }, status: :ok
        else
            render json: { errors: ['Invalid confirmation token'] }, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user)
            .permit(:username, :email, :password, :password_confirmation, :bio, :image)
    end
end
