class PostsController < ApplicationController
	before_action :signed_in_master

	def create
		@post = current_master.posts.build(post_params)
		if @post.save
			flash[:success] = "Post created!"
			redirect_to root_url
		else
			render 'static_pages/home'
		end
	end

	def destroy
	end

	private

		def post_params
			params.require(:post).permit(:content)
		end
end