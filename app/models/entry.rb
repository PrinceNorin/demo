class Entry < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  
  validates :user, presence: true
end
