class User < ApplicationRecord
    has_many :borrow

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
end
