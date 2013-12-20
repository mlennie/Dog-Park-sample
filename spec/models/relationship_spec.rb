require 'spec_helper'

describe Relationship do
  
  let(:follower) { FactoryGirl.create(:master) }
  let(:followed) { FactoryGirl.create(:master) }
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }

  subject { relationship }

  it { should be_valid }

  context "follower methods" do 
  	it { should respond_to(:follower) }
  	it { should respond_to(:followed) }
  	its(:follower) { should eq follower }
  	its(:followed) { should eq followed }
  end

  context "when followed id is not present" do 
  	before { relationship.followed_id = nil }
  	it { should_not be_valid }
  end

  context "when follower id is not present" do 
  	before { relationship.follower_id = nil }
  	it { should_not be_valid }
  end
end
