require 'spec_helper'

describe "StaticPages" do
  subject { page }

  context "Home page" do 
  	before { visit root_path }

  	it { should have_content("Welcome") }
  	it { should have_title("Dog Park") }
  end

  context "About page" do 
  	before { visit about_path }

  	it { should have_content("About") }
  	it { should have_title("Dog Park | About") }
  end

  context "Contact page" do 
  	before { visit contact_path }

  	it { should have_content("Contact") }
  	it { should have_title("Dog Park | Contact") }
  end

  context "Faq page" do 
  	before { visit faq_path }

  	it { should have_content("FAQ") }
  	it { should have_title("Dog Park | FAQ") }
  end
end
