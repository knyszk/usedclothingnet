class Photo < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments


  
  # validates :photo, presence: true
  validates :caption, presence: true, length: { maximum: 2000 }
  
  has_one_attached :image
end
