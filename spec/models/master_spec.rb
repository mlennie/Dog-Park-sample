require 'spec_helper'

describe Master do

  before do
   @master = Master.new(name: "Baxter", email: "baxter@bark.com",
   				  password: "foobar", password_confirmation: "foobar")
  end

  subject { @master }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }

  it { should be_valid }
  it { should_not be_admin }

  context "with admin attribute set to 'true'" do 
    before do 
      @master.save!
      @master.toggle!(:admin)
    end

    it { should be_admin }
  end

  context "when name is not present" do 
  	before { @master.name = " " }
  	it { should_not be_valid }
  end

  context "when name is too long" do 
  	before { @master.name = 'a' * 51 }
  	it { should_not be_valid }

  end

  context "when email is not present" do 
  	before { @master.email = " " }
  	it { should_not be_valid }
  end

  context "when email format is invalid" do 
  	it "should be invalid" do 
  		addresses = %w[foo@bar..com user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
        	@master.email = invalid_address
        	expect(@master).not_to be_valid
        end 
  	end
  end

  context "when email format is valid" do
  	it "should be valid" do 
  		addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  		addresses.each do |valid_address|
  			@master.email = valid_address
  			expect(@master).to be_valid
  		end
  	end
  end

  context "when email address is already taken" do 
  	before do
  		master_with_same_email = @master.dup
  		master_with_same_email.email = @master.email.upcase
  		master_with_same_email.save
  	end

    it { should_not be_valid }
  end

  context "email address with mixed case" do 
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower_case" do 
      @master.email = mixed_case_email
      @master.save
      expect(@master.reload.email).to eq mixed_case_email.downcase
    end
  end

  context "when password is not present" do 
  	before do 
  		@master = Master.new(name: "Baxter", email: "baxter@bark.com",
  					   password: " ", password_confirmation: " ")
  	end

  	it { should_not be_valid }
  end

  context "when password is too short" do 
    before { @master.password = @master.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  context "when password doesn't match confirmation" do 
  	before { @master.password_confirmation = "mismatch" }
  	it { should_not be_valid }
  end

  context "return value of authenticate method" do 
    before { @master.save }
    let(:found_master) { Master.find_by(email: @master.email) }

    context "with valid password" do 
      it { should eq found_master.authenticate(@master.password) }
    end

    context "with invalid password" do 
      let(:master_for_invalid_password) { found_master.authenticate("invalid") }

      it { should_not eq master_for_invalid_password }
      specify { expect(master_for_invalid_password).to be_false }
    end
  end

  context "remember token" do 
    before { @master.save }
    its(:remember_token) { should_not be_blank }
  end
end















