class Book < ApplicationRecord
  belongs_to :publisher_author

  validates :isbn, presence: true, uniqueness: true
  validates :name, presence: true
  validates :copies, presence: true
  validates :late_return_penalty, presence: true
end
