module DogsHelper

	#Returns the Gravatar (http://gravatar.com/) for the given user.

	def gravatar_for(dog)
		gravatar_id = Digest::MD5::hexdigest(dog.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: dog.name, class: "gravatar")
	end
end
