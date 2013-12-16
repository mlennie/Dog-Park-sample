class Post < ActiveRecord::Base
	belongs_to :master
	default_scope -> { order('created_at DESC') }
	validates :master_id, presence: true
	validates :content, presence: true, length: { maximum: 5000 }
end
 