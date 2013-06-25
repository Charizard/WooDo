require 'spec_helper'

describe "StaticPages" do
    
    subject { page }
    
    describe "Home Page" do
        before { visit '/static_pages/home' }

        it { should have_selector('h1', text: 'Woo Do') }
        it { should have_selector('title', text: 'Woo Do | Save Tasks') }
        it { should have_link('Sign up') }
    end
end
