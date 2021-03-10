class Post < ApplicationRecord
    belongs_to :user
    
    has_many :comments, dependent: :destroy

    validates :content, presence: false, length: { maximum: 255 }
    
    has_one_attached :image
    
   
end
