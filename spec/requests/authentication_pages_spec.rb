require 'spec_helper'

describe "Authentication" do
  
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

  		it { should have_title(master.name) }
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

  context "authorization" do 

    context "for non-signed-in masters" do 
      let(:master) { FactoryGirl.create(:master) }

      context "when attempting to visit a protected page" do 
        before do
          visit edit_master_path(master)
          fill_in "Email", with: master.email
          fill_in "Password", with: master.password
          click_button "Play Time"
        end

        context "after signing in" do 
          it { should have_title('Edit Master')}
        end
      end

      context "visiting the edit page" do 
        before { visit edit_master_path(master) }
        it { should have_title('Play Time') }
      end

      context "submitting to the update action" do 
        before { patch master_path(master) }
        specify { expect(response).to redirect_to(playtime_path) }
      end

      context "visiting the master index" do 
        before { visit masters_path }
        it { should have_title('Play Time')}
      end
    end

    context "as wrong master" do 
      let(:master) { FactoryGirl.create(:master) }
      let(:wrong_master) { FactoryGirl.create(:master, email: "wrong@example.com") }
      before { sign_in master, no_capybara: true }

      context "submitting a GET request to the Masters#edit action" do 
        before { get edit_master_path(wrong_master) }
        specify { expect(response.body).not_to match('Edit Master') }
        specify { expect(response).to redirect_to(root_url) }
      end

      context "sumbitting a PATCH request to the Masters#edit action" do 
        before { patch master_path(wrong_master) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
  end
end























