class User < ActiveRecord::Base
  # active record callback
  before_save :downcase_email
  
  # associations
  has_many :entries
  
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
  
  # helper methods
  private
    # downcase email to prevent case sensitive
    # comparision when do uniqueness validation
    def downcase_email
      self.email.downcase!
    end
end