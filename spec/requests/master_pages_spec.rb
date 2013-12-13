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

        it { should have_link('Nap Time') }
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

  context "edit" do 
    let(:master) { FactoryGirl.create(:master) }
    before do 
      sign_in master
      visit edit_master_path(master) 
   end

    context "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit Master") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    context "with invalid information" do 
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    context "with valid information" do 
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do 
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: master.password
        fill_in "Confirm Password", with: master.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Nap Time', href: naptime_path) }
      specify { expect(master.reload.name).to eq new_name }
      specify { expect(master.reload.email).to eq new_email }
    end
  end

  context "index page" do 
    before do 
      sign_in FactoryGirl.create(:master) 
      FactoryGirl.create(:master, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:master, name: "Ben", email: "ben@example.com")
      visit masters_path
    end

    it { should have_title('All masters') }
    it { should have_content('All masters') }

    it "should list each master" do 
      Master.all.each do |master|
        expect(page).to have_selector('li', text: master.name)
      end
    end

    context "pagination" do 

      before(:all) { 30.times { FactoryGirl.create(:master) } }
      after(:all) { Master.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each master" do 
        Master.paginate(page: 1).each do |master|
          expect(page).to have_selector('li', text: master.name)
        end
      end
    end
  end
end

























