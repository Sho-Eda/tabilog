class Post < ApplicationRecord
    belongs_to :user
    
    has_many :comments, dependent: :destroy
    has_many :tag_maps, dependent: :destroy
    has_many :tags, through: :tag_maps
    
    # validates :image, presence: true
    validates :content, presence: false, length: { maximum: 255 }
    
    has_one_attached :image
    
    
    # createアクションで記述したsave_tagインスタンスメソッド
    def save_tag(savepost_tags)
        savepost_tags.each do |new_name|
        post_tag = Tag.find_or_create_by(name: new_name)
        self.tags << post_tag
        end
    end
    
   
end
