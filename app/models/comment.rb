class Comment < ActiveRecord::Base
  belongs_to :entry
  belongs_to :user
  
  validates :entry, presence: true
  validates :user, presence: true
  validates :content, presence: true
  
  def commented_at
    created_at.strftime("%d/%m/%y - %H:%M %p")
  end
end
