class Post < ApplicationRecord
    belongs_to :user
    validates :content, presence: false, length: { maximum: 255 }
    # validates :images, blob: { content_type: %w(image/png image/jpg image/jpeg) }
    
    # 画像サイズ
    # image_tag @post.image.variant(resize_to_fill: [128, 128])
    
    has_one_attached :image
end
