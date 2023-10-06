class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :prototype
 
  validates :content, presence: true
  #validates :user, presence: true
  #validates :prototype, presence: true


end
