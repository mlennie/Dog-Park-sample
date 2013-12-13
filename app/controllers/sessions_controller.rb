class SessionsController < ApplicationController

	def new
	end

	def create
		master = Master.find_by(email: params[:session][:email].downcase)
		if master && master.authenticate(params[:session][:password])
			sign_in master
			redirect_back_or master
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		flash[:success] = 'You have been signed out. Come back soon!'
		sign_out
		redirect_to root_url
	end
end
