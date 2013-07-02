require 'spec_helper'

describe "User Pages" do
    subject { page }

    describe "Sign up Page" do
        before { visit signup_path }

        it { should have_title("Sign up") }
        it { should have_selector('h1', text: "Sign up") }

        describe "fill in form with valid information" do
            before do
                fill_in "Name",                     with: "Yuvaraja"
                fill_in "Email",                    with: "yuv.slm@gmail.com"
                fill_in "Password",                 with: "foobar"
                fill_in "Confirmation",             with: "foobar"
            end

            it "should create new user" do
                expect { click_button "Create my account" }.to change(User, :count).by(1)
            end
            describe "new created user should be displayed with welcome message" do
                before { click_button "Create my account" }
                it { should have_content('Created new user.') }
            end

            describe "newly created users should be signed in" do
                before { click_button "Create my account" }
                it { should have_link('Sign out', href: signout_path) }
                it { should_not have_link('Sign in', href: signin_path) }
            end
        end

        describe "fill in form with invalid information" do
            before do
                fill_in "Name",                     with: ""
                fill_in "Email",                    with: "yuv.slm@gmail"
                fill_in "Password",                 with: "foobar"
                fill_in "Confirmation",             with: "foobar"
            end

            it { should have_title("Sign up") }
            it { should have_selector('h1', text: "Sign up") }
        end
    end


    describe "Profile page" do
        let(:user) { FactoryGirl.create(:user) }
        before { visit user_path(user) }

        it { should have_title(user.name) }
        it { should have_selector('h1', text: user.name) }
    end
end
