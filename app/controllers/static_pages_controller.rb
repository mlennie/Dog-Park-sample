class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		@post = current_master.posts.build
  		@feed_items = current_master.feed.paginate(page: params[:page])
  	end
  end

  def about
  end

  def contact
  end

  def faq
  end
end
