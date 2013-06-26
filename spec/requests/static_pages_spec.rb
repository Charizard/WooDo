require 'spec_helper'

describe "StaticPages" do
    
    subject { page }
    
    describe "Home Page" do
        before { visit '/static_pages/home' }

        it { should have_selector('h1', text: 'Woo Do') }
        it { should have_selector('title', text: 'Woo Do | Save Tasks') }
        it { should have_link('Sign up') }
        
        describe "after signin" do
            let(:user) { FactoryGirl.create(:user) }
            let!(:list) { FactoryGirl.create(:list, title: "List Name") }

            before do
                user.posses!(list)
                sign_in user
            end

            it { should have_content(list.title) }
        end
    end
end
