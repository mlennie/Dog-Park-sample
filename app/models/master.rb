class Master < ActiveRecord::Base
	before_save { email.downcase! }
	before_create :create_remember_token
	has_secure_password
    validates :password, length: { minimum: 6 }
	validates :name, presence: true, 
					 length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true,
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }

	def Master.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def Master.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end
	
	private 

		def create_remember_token
			self.remember_token = Master.encrypt(Master.new_remember_token)
		end
end
