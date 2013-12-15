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
end
