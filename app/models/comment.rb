class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :photo, optional: true
  
  # validates :comment, presence: false, length: { maximum: 200 }
end
