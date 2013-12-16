namespace :db do 
	desc "Fill database with sample data" 
	task populate: :environment do 
		admin = Master.create!(name: "Monty Lennie",
							   email: "montylennie@gmail.com",
							   password: "foobar",
							   password_confirmation: "foobar",
							   admin: true)
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n + 1}@railstutorial.org"
			password = "password"
			Master.create!(name: name,
						   email: email,
						   password: password,
						   password_confirmation: password)
		end

		masters = Master.all(limit: 6)
		50.times do 
			content = Faker::Lorem.sentence(5)
			masters.each { |master| master.posts.create!(content: content) }
		end
	end
end