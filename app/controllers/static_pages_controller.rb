class StaticPagesController < ApplicationController
  def home
  	@post = current_master.posts.build if signed_in?
  end

  def about
  end

  def contact
  end

  def faq
  end
end
