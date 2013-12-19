require 'spec_helper'

describe "Post pages" do 

	subject { page }

	let(:master) { FactoryGirl.create(:master) }
	before { sign_in master }

	context "post creation" do 
		before { visit root_path }

		context "with invalid information" do 

			it "should not create a post" do 
				expect { click_button "Post" }.not_to change(Post, :count)
			end

			context "error messages" do 
				before { click_button "Post" }
				it { should have_content('error') }
			end
		end

		context "with valid information" do 

			before { fill_in 'post_content', with: "Lorem ipsum" }
			it "should create a post" do 
				expect { click_button "Post" }.to change(Post, :count).by(1)
			end
		end
	end

	context "post destruction" do 
		before { FactoryGirl.create(:post, master: master) }

		context "as correct master" do 
			before { visit root_path }

			it "should delete a post" do 
				expect { click_link "delete" }.to change(Post, :count).by(-1)
			end
		end
	end
end

















