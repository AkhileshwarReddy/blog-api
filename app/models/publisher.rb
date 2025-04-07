class Publisher < ApplicationRecord
    has_many :publisher_author, dependent: :destroy
    has_many :authors, through: :publisher_author

    validates :name, presence: true
end
