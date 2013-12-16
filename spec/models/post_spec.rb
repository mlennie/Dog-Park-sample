require 'spec_helper'

describe Post do

	let(:master) { FactoryGirl.create(:master) }
	before { @post = master.posts.build(content: "Lorem ipsum") }

	subject { @post }

	it { should respond_to(:content) }
	it { should respond_to(:master_id) }
	it { should respond_to(:master) }
	its(:master) { should eq master }

	it { should be_valid }

	context "when master_id is not present" do 
		before { @post.master_id = nil }
		it { should_not be_valid }
	end

	context "with blank content" do 
		before { @post.content = " " }
		it { should_not be_valid }
	end

	context "with content that is too long" do 
		before { @post.content = "a" * 5001 }
		it { should_not be_valid }
	end
end
