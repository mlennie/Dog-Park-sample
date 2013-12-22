namespace :db do 
	desc "Fill database with sample data" 
	task populate: :environment do 
		make_masters
		make_posts
		make_relationships
	end
end

def make_masters
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
end

def make_posts
	masters = Master.all(limit: 6)
	50.times do 
		content = Faker::Lorem.sentence(5)
		masters.each { |master| master.posts.create!(content: content) }
	end
end

def make_relationships
	masters = Master.all
	master = masters.first
	followed_masters = masters[2..50]
	followers = masters[3..40]
	followed_masters.each { |followed| master.follow!(followed)  }
	followers.each { |follower| follower.follow!(master)  }
end
		

		