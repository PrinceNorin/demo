class Entry < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  default_scope -> { order('created_at DESC') }
  
  validates :user, presence: true
  validates :title, presence: true
  validates :body, presence: true
  
  def posted_at
    created_at.strftime('%B %d, %Y')
  end
end
