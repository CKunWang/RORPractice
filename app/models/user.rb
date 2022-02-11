class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :api_access_tokens
  
  def self.find_user(email)
	user = find_by(email: email)
  end
  
  def self.has_duplicate_user?(email)
    !find_user(email).blank?
  end
  
  def self.validate_user (email, password)
	return false unless user = find_user(email)
	return false unless user.valid_password?(password)
	user
  end
  
  def isAdmin?
    self.role == "admin"
  end
end
