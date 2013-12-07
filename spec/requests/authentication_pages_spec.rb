require 'spec_helper'

describe "AuthenticationPages" do
  
  subject { page }

  context "signin page" do 
  	before { visit playtime_path }

  	it { should have_content('Play Time') }
  	it { should have_title('Play Time') }
  end

  context "signin" do 
  	before { visit playtime_path }

  	context "with invalid information" do 
  		before { click_button "Play Time" }

  		it { should have_title('Play Time') }
  		it { should have_selector('div.alert.alert-error', text: 'Invalid') }
  	end

  	context "with valid information" do 
  		let(:dog) { FactoryGirl.create(:dog) }
  		before do 
  			fill_in "Email", with: dog.email.upcase
  			fill_in "Password", with: dog.password
  			click_button "Play Time"
  		end

  		it { should have_title(dog.name) }
  		it { should have_link('Backyard', href: dog_path(dog)) }
  		it { should have_link('NapTime', href: naptime_path) }
  		it { should_not have_link('Play Time', href: playtime_path)}
  	end
  end
end
