require 'spec_helper'

describe "DogPages" do
  subject { page }

  context "signup page" do 
  	before { visit signup_path }

  	it { should have_selector('h1', text: 'Sign up') }
  	it { should have_title('Sign up')}

  end

  context "signup" do 

    before { visit signup_path }

    let(:submit) { "Create my account" }

    context "with invalid information" do 
      it "should not create a dog" do 
        expect { click_button submit }.to_not change(Dog, :count)
      end

      context "after submission" do 
        before { click_button submit }

        it { should have_title('Sign up') }
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
        fill_in "Name",                  with: "Baxter Mcard"
        fill_in "Email",                 with: "baxter@bark.com"
        fill_in "Password",              with: "woofwoof"
        fill_in "Password Confirmation", with: "woofwoof"
      end

      it "should create a dog" do 
        expect { click_button submit }.to change(Dog, :count).by(1)
      end
    end
  end

  context "profile page" do 
  	let(:dog) { FactoryGirl.create(:dog) }
  	before { visit dog_path(dog) }

  	it { should have_content(dog.name) }
  	it { should have_title(dog.name) }
  end


end
