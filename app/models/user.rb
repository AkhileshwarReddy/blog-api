class User < ApplicationRecord
    has_secure_password

    has_many :posts

    has_many :follows, foreign_key: :follower_id, dependent: :destroy
    has_many :following, through: :follows, source: :followed
    has_many :reverse_follows, foreign_key: :followed_id, class_name: 'Follow', dependent: :destroy
    has_many :followers, through: :reverse_follows, source: :follower
    
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }, if: :password
end
