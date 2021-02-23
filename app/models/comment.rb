class Comment < ApplicationRecord
  validates :comment, presence: false, length: { maximum: 255 }
  belongs_to :user
  belongs_to :post
end
