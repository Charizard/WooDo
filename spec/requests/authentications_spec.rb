require 'spec_helper'

describe "Authentications" do

  subject {page}

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('title',text: "Sign in") }
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
        it { should have_selector('title', text: user.name) }
        it { should_not have_link('Sign in') }
        it { should have_selector('div.task-creator') }

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
