class Post < ActiveRecord::Base
	belongs_to :master
	default_scope -> { order('created_at DESC') }
	validates :master_id, presence: true
	validates :content, presence: true, length: { maximum: 5000 }

	def self.from_masters_followed_by(master)
		followed_master_ids = "SELECT followed_id FROM relationships
							  WHERE follower_id = :master_id"
		where("master_id IN (#{followed_master_ids}) OR master_id = :master_id",
			   master_id: master)
	end
end

 