require 'spec_helper'

describe "DogPages" do
  subject { page }

  context "signup page" do 
  	before { visit signup_path }

  	it { should have_content('Sign up') }
  	it { should have_title('Sign up')}

  end
end
