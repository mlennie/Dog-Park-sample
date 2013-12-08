module SessionsHelper
	def sign_in(master)
		remember_token = Master.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		master.update_attribute(:remember_token, Master.encrypt(remember_token))
		self.current_master = master
	end
end
