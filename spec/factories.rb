FactoryGirl.define do 
	factory :master do 
		sequence(:name)  { |n| "Person #{n}" }
		sequence(:email) { |n| "Person_#{n}@example.com" }
		password "foobar"
		password_confirmation "foobar"

		factory :admin do 
			admin true
		end
	end

	factory :post do 
		content "Lorem ipsum"
		master
	end
end