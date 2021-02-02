class Photo < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :users, through: :likes

def liked_by?(user)
  likes.where(user_id: user.id).exists?
end
  
  # validates :photo, presence: true
  validates :caption, presence: false, length: { maximum: 2000 }
  
  has_one_attached :image
end
