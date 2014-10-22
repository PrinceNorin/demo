class User < ActiveRecord::Base
  # active record callback
  before_save :downcase_email
  
  # associations
  has_many :entries, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  # followed and following
  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reversed_relationships, foreign_key: :followed_id,
           class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :reversed_relationships, source: :follower
  
  # valid email address regexp
  VALID_ADDRESS = /\A[^@\s]+@[\w\-_\.]+\.\w{2,4}/i
  
  # validates user email
  validates :email, format: { with: VALID_ADDRESS }
  validates :email, uniqueness: true
  validates :email, presence: true
  
  # validates user password
  validates :password, length: { minimum: 6 }
  
  # validates user name
  validates :name, length: { minimum: 5 }
  validates :name, presence: true, uniqueness: true
  
  # method that generate password
  # and password_confirmation
  # attribute accessor for
  # security in login system
  # it require password_digest
  # column in User model
  has_secure_password
  
  def member_since
    created_at.strftime '%B %d, %Y'
  end
  
  def following?(user)
    relationships.find_by followed_id: user.id
  end
  
  def follow!(user)
    relationships.create! followed_id: user.id
  end
  
  def unfollow!(user)
    relationships.find_by(followed_id: user.id).destroy
  end
  
  # helper methods
  private
    # downcase email to prevent case sensitive
    # comparision when do uniqueness validation
    def downcase_email
      self.email.downcase!
    end
end
