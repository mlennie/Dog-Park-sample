class SessionsController < ApplicationController

	def new
	end

	def create
		master = Master.find_by(email: params[:session][:email].downcase)
		if master && master.authenticate(params[:session][:password])
			sign_in master
			redirect_to root_path
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
	end
end
