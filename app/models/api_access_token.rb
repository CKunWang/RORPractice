class ApiAccessToken < ApplicationRecord
	belongs_to :user, optional: true
	
	before_create :generate_keys
	
	def self.get_available_token (token)
	  self.joins(:user).where(key: token).where("expired_time > ?", Time.now.utc).first
	end
	
	private
	
	def generate_keys
		begin
			self.key = SecureRandom.urlsafe_base64(30).tr('_-', 'xx')
		end while ApiAccessToken.where(key: key).any?
	end
	
end
