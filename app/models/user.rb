class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    
    has_secure_password
    
    has_many :posts
    has_many :relationships
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverses_of_relationship, source: :user
    
    # 「自分がお気に入りしているMicropost」への参照を表している。
    has_many :favorites
    # 中間テーブルを経由して相手の情報を取得できるようにするためには through を使用する。
    has_many :likes, through: :favorites, source: :post
    
    
    def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
    end
    
    def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
    end
    
    def following?(other_user)
    self.followings.include?(other_user)
    end
    
     def like(post)
      # unless self == micropostによってお気に入りしようとしているmicropost が自分自身ではないかを検証している。
      # 実行した User のインスタンスが self
      unless self == post
      # 既にフォローされている場合にフォローが重複して保存されることがなくなる。
        self.favorites.find_or_create_by(post_id: post.id)
      end
     end

      def unlike(post)
        favorite = self.favorites.find_by(post_id: post.id)
        favorite.destroy if favorite
      end
      
      
      def like?(post) 
        self.likes.include?(post) #self.bookmarksで登録しているお気に入りを取得。include?(other_user) によって other_user が含まれていないかを確認しています。
      end
end
