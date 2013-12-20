class Master < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_masters, through: :relationships, source: :followed 
	has_many :reverse_relationships, foreign_key: "followed_id",
									 class_name: "Relationship",
									 dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower
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

	def feed
		#this is the preliminary
		Post.where("master_id = ?", id)
	end

	def following?(other_master) 
		self.relationships.find_by(followed_id: other_master.id)
	end

	def follow!(other_master)
		self.relationships.create!(followed_id: other_master.id)
	end

	def unfollow!(other_master)
		self.relationships.find_by(followed_id: other_master.id).destroy
	end
	
	private 

		def create_remember_token
			self.remember_token = Master.encrypt(Master.new_remember_token)
		end
end
