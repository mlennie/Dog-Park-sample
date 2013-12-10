module SessionsHelper
	def sign_in(master)
		remember_token = Master.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		master.update_attribute(:remember_token, Master.encrypt(remember_token))
		self.current_master = master
	end

	def signed_in?
		!current_master.nil?
	end

	def current_master=(master)
		@current_master = master
	end

	def current_master
		remember_token = Master.encrypt(cookies[:remember_token] )
		@current_master ||= Master.find_by(remember_token: remember_token)
	end

	def sign_out
		self.current_master = nil
		cookies.delete(:remember_token)
	end
end
