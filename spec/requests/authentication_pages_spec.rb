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

      context "after visiting another page" do 
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
  	end

  	context "with valid information" do 
  		let(:master) { FactoryGirl.create(:master) }
  		before do 
  			fill_in "Email", with: master.email.upcase
  			fill_in "Password", with: master.password
  			click_button "Play Time"
  		end

  		it { should have_title(master.name) }
  		it { should have_link('Home', href: master_path(dog)) }
  		it { should have_link('NapTime', href: naptime_path) }
  		it { should_not have_link('Play Time', href: playtime_path)}
  	end
  end
end
