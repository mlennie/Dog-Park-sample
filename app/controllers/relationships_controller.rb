class RelationshipsController < ApplicationController
	before_action :signed_in_master

	def create
		@master = Master.find(params[:relationship][:followed_id])
		current_master.follow!(@master)
		respond_to do |format|
			format.html { redirect_to @master }
			format.js
		end
	end

	def destroy
		@master = Relationship.find(params[:id]).followed
		current_master.unfollow!(@master)
		respond_to do |format| 
			format.html { redirect_to @master }
			format.js
		end
	end
end