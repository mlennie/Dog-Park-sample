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

	def current_master?(master)
		master == current_master
	end

	def signed_in_master
      unless signed_in?
        store_location
        redirect_to playtime_url, notice: "Please sign in."
      end
    end

	def sign_out
		self.current_master = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url if request.get?
	end
end
