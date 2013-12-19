class PostsController < ApplicationController
	before_action :signed_in_master
	before_action :correct_master, only: :destroy

	def create
		@post = current_master.posts.build(post_params)
		if @post.save
			flash[:success] = "Post created!"
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end

	def destroy
		@post.destroy
		redirect_to root_url
	end

	private

		def post_params
			params.require(:post).permit(:content)
		end

		def correct_master
			@post = current_master.posts.find_by(id: params[:id])
			redirect_to root_url if @post.nil?
		end
end