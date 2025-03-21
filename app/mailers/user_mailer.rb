class UserMailer < ApplicationMailer
    default from: 'no-reply@blogapi.com'

    def confirmation_email(user)
        @user = user
        @url = "http://localhost:3000/confirm?token=#{user.confirmation_token}"

        mail(to: @user.email, subject: 'Confirm your account')
    end
end
