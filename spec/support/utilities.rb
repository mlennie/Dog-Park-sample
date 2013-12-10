def sign_in(master, options={})
	if options[:no_capybara]
		#sign in when not using Capybara
		remember_token = Master.new_remember_token
		cookies[:remember_token] = remember_token
		master.update_attribute(:remember_token, Master.encrypt(remember_token))
	else
		visit playtime_path
		fill_in "Email", with: master.email
		fill_in "Password", with: master.password
		click_button "Play Time"
	end
end
