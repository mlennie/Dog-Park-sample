class Relationship < ActiveRecord::Base
	belongs_to :follower, class_name: "Master"
	belongs_to :followed, class_name: "Master"
	validates :follower_id, presence: true
	validates :followed_id, presence: true
end
