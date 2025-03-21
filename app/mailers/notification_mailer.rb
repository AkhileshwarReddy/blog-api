class NotificationMailer < ApplicationMailer
    default from: 'no-reply@blogapi.com'

    def new_post_notification(user, post)
        @user = user
        @post = post
        p user.email, post.title

        mail(to: @user.email, subject: 'New post notification')
    end
end
