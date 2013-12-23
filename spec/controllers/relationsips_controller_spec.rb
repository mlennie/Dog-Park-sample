require 'spec_helper'

describe RelationshipsController do 

	let(:master) { FactoryGirl.create(:master) }
	let(:other_master) { FactoryGirl.create(:master) }

	before { sign_in master, no_capybara: true }

	context "creating a relationship with Ajax" do 

		it "should increment the Relationship count" do 
			expect do 
				xhr :post, :create, relationship: { followed_id: other_master.id }
			end.to change(Relationship, :count).by(1)
		end

		it "should respond with success" do 
			xhr :post, :create, relationship: { followed_id: other_master.id }
			expect(response).to be_success
		end
	end

	context "destroying a relationship with Ajax" do 

		before { master.follow!(other_master) }
		let(:relationship) { master.relationships.find_by(followed_id: other_master)}

		it "should decrement the Relationship count" do 
			expect do 
				xhr :delete, :destroy, id: relationship.id
			end.to change(Relationship, :count).by(-1)
		end

		it "should respond with success" do 
			xhr :delete, :destroy, id: relationship.id
			expect(response).to be_success
		end
	end
end