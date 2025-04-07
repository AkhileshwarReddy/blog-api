class Author < ApplicationRecord
    has_many :publisher_author, dependent: :destroy
    has_many :publishers, through: :publisher_author

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
end
