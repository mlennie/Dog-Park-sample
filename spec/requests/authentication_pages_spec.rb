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
  		before { sign_in master }

  		it { should have_title("Home") }
  		it { should have_link('Dog Park', href: root_path) }
  		it { should have_link('Backyard', href: backyard_path) }
      it { should have_link('Account', href: '#') }
  		it { should_not have_link('Play Time', href: playtime_path)}
      it { should have_link('Home', href: master_path(master)) }
      it { should have_link('Settings', href: edit_master_path(master)) }
      it { should have_link('Nap Time', href: naptime_path) }

      context "followed by signout" do 
        before { click_link "Nap Time" }
        it { should have_link('Play Time') }
      end
    end 
  end
end
