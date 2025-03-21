class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags
  has_many :tags, through: :post_tags

  validates :title, presence: true
  validates :body, preseemce: true
  validates :status, inclusion: { in: %w(draft published archived) }
end
