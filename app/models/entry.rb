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
  
  def self.latest_by_followings_users_and(user)
    following_user_ids = "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id"
    where "user_id IN (#{following_user_ids}) OR user_id = :user_id", user_id: user.id
  end
end
