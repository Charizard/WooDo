require 'spec_helper'

describe "Lists" do
    
    let(:user) { FactoryGirl.create(:user) }
    let!(:list) { FactoryGirl.create(:list, title: "Another Sample 97") }


    before do
        user.posses!(list)
        sign_in user
        visit '/'
    end

    subject {page}

    describe "List deletion" do
    	before do
    		click_link "list-delete"
    		page.driver.browser.switch_to.alert.accept
    	end

    	it "should delete list", :js => true do
    		should_not have_content(list.title)
    	end
    end
end
