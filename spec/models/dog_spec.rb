require 'spec_helper'

describe Dog do

  before do
   @dog = Dog.new(name: "Baxter", email: "baxter@bark.com",
   				  password: "foobar", password_confirmation: "foobar")
  end

  subject { @dog }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  context "when name is not present" do 
  	before { @dog.name = " " }
  	it { should_not be_valid }
  end

  context "when name is too long" do 
  	before { @dog.name = 'a' * 51 }
  	it { should_not be_valid }

  end

  context "when email is not present" do 
  	before { @dog.email = " " }
  	it { should_not be_valid }
  end

  context "when email format is invalid" do 
  	it "should be invalid" do 
  		addresses = %w[foo@bar..com user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
        	@dog.email = invalid_address
        	expect(@dog).not_to be_valid
        end 
  	end
  end

  context "when email format is valid" do
  	it "should be valid" do 
  		addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  		addresses.each do |valid_address|
  			@dog.email = valid_address
  			expect(@dog).to be_valid
  		end
  	end
  end

  context "when email address is already taken" do 
  	before do
  		dog_with_same_email = @dog.dup
  		dog_with_same_email.email = @dog.email.upcase
  		dog_with_same_email.save
  	end

    it { should_not be_valid }
  end

  context "email address with mixed case" do 
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower_case" do 
      @dog.email = mixed_case_email
      @dog.save
      expect(@dog.reload.email).to eq mixed_case_email.downcase
    end
  end

  context "when password is not present" do 
  	before do 
  		@dog = Dog.new(name: "Baxter", email: "baxter@bark.com",
  					   password: " ", password_confirmation: " ")
  	end

  	it { should_not be_valid }
  end

  context "when password is too short" do 
    before { @dog.password = @dog.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  context "when password doesn't match confirmation" do 
  	before { @dog.password_confirmation = "mismatch" }
  	it { should_not be_valid }
  end

  context "return value of authenticate method" do 
    before { @dog.save }
    let(:found_dog) { Dog.find_by(email: @dog.email) }

    context "with valid password" do 
      it { should eq found_dog.authenticate(@dog.password) }
    end

    context "with invalid password" do 
      let(:dog_for_invalid_password) { found_dog.authenticate("invalid") }

      it { should_not eq dog_for_invalid_password }
      specify { expect(dog_for_invalid_password).to be_false }
    end
  end
end















