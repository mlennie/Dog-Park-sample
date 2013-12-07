require 'spec_helper'

describe "MasterPages" do
  subject { page }

  context "signup page" do 
  	before { visit join_path }

  	it { should have_selector('h1', text: 'Join the pack') }
  	it { should have_title('Join')}

  end

  context "signup" do 

    before { visit join_path }

    let(:submit) { "Join the Pack" }

    context "with invalid information" do 
      it "should not create a master" do 
        expect { click_button submit }.to_not change(Master, :count)
      end

      context "after submission" do 
        before { click_button submit }

        it { should have_title('Join') }
        it { should have_content('error') }
        it { should have_content("Name can't be blank") }
        it { should have_content("Email can't be blank") }
        it { should have_content("Email is invalid") }
        it { should have_content("Password can't be blank") }
        it { should have_content("Password is too short (minimum is 6 characters)")}
      end
    end

    context "with valid information" do 
      before do 
        fill_in "Master's Name",                  with: "Mr Magoo"
        fill_in "Master's Email",                 with: "master@master.com"
        fill_in "Master's password",              with: "123456"
        fill_in "Password Confirmation",          with: "123456"
      end

      it "should create a master" do 
        expect { click_button submit }.to change(Master, :count).by(1)
      end

      context "after saving the master" do 
        before { click_button submit }
        let(:master) { Master.find_by(email: 'master@master.com') }

        it { should have_title(master.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end

  context "profile page" do 
  	let(:master) { FactoryGirl.create(:master) }
  	before { visit master_path(master) }

  	it { should have_content(master.name) }
  	it { should have_title(master.name) }
  end
end
