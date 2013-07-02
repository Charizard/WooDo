require 'spec_helper'

describe "Authentications" do
  subject {page}

  describe "signin page" do
    before { visit signin_path }

    it { should have_title("Sign in") }
    it { should have_selector('h1', text: "Sign in") }

    describe "with invalid information" do
        before do
            click_button "Sign in"
        end

        it { should have_selector('div.alert.alert-error', text: "Invalid") }
    end

    describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before do
            fill_in "Email",        with: user.email
            fill_in "Password",     with: user.password
            click_button "Sign in"
        end
        

        it { should have_link('Sign out') }
        it { should have_link('Profile') }
        it { should_not have_link('Sign in') }
        it { should have_button('Create') }

        describe "List and Task creation" do
            describe "with valid information" do
                let(:new_list) { "New List" }
                let(:new_task) { "New Task" }
                before do                    
                    fill_in "task_content",     with: "#{new_task}@#{new_list}"
                    click_button "Create"
                end

                it "new_list present", :js => true do
                    should have_content(new_list)
                end
                it "new_task present", :js => true do
                    should have_content(new_task)
                end
            end
        end

        describe "should redirect root url" do
            it { should have_title("Woo Do") }
            
            describe "root url should not contain static page" do
                it { should_not have_selector('h1', text: "Woo Do | Save Tasks") }
                it { should_not have_link('Sign up') }
            end
        end

        describe "Sign out" do
            before do
                click_link "Sign out"
            end

            it { should_not have_link('Sign out') }
            it { should have_link('Sign in') }
        end
    end
end
end
