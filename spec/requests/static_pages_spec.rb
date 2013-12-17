require 'spec_helper'

describe "StaticPages" do
  subject { page }

  shared_examples_for "all static pages" do 
    it { should have_selector('h1', text: heading) }
    it { should have_title(page_title) }
  end

  context "Home page" do 
  	before { visit root_path }
    let(:heading) { 'Welcome' }
    let(:page_title) { 'Dog Park' }

    it_should_behave_like "all static pages"

    context "for signed-in masters" do 
      let(:master) { FactoryGirl.create(:master) }
      before do 
        FactoryGirl.create(:post, master: master, content: "Lorem ipsum")
        FacotryGirl.create(:post, master: master, content: "Dolor sit amet")
        sign_in master
        visit root_path
      end

      it "should render the master's feed" do 
        master.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end

  context "About page" do 
  	before { visit about_path }
    let(:heading) { 'About' }
    let(:page_title) { 'About' }

  	it_should_behave_like "all static pages"
  end

  context "Contact page" do 
  	before { visit contact_path }
    let(:heading) { 'Contact' }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all static pages"
  end

  context "Faq page" do 
  	before { visit faq_path }
    let(:heading) { 'FAQ' }
    let(:page_title) { 'FAQ' }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do 
    visit root_path
    click_link "About"
    expect(page).to have_title('About')
    click_link "Contact"
    expect(page).to have_title('Contact')
    click_link "FAQ"
    expect(page).to have_title('FAQ')
    click_link "Home"
    expect(page).to have_title('Home')
    click_link "Join the pack!"
    expect(page).to have_title('Join')
  end
end















