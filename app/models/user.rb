class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    
    has_many :favorites
    has_many :likes, through: :favorites, source: :vote
    
    def favorite(review)
      self.favorites.find_or_create_by(vote_id: review.vote_id)
    end
  
    def unfavorite(review)
      favorite = self.favorites.find_by(vote_id: review.vote_id)
      favorite.destroy if favorite
    end
  
    def favorite?(review)
      self.likes.include?(vote_id: review)
    end
end
