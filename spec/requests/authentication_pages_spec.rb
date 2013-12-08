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

  		it { should have_title("Home") }
  		it { should have_link('Dog Park', href: root_path) }
  		it { should have_link('Backyard', href: backyard_path) }
      it { should have_link('Account', href: '#') }
  		it { should_not have_link('Play Time', href: playtime_path)}

      context "it should have dropdown with proper links" do 
        before { click_link "Account" }

        it { should have_link('Home', href: master_path(master)) }
        it { should have_link('Settings', href: '#') }
        it { should have_link('Nap Time', href: naptime_path) }
      end
    end 
  end
end
