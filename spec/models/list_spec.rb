require 'spec_helper'

describe List do
    let(:user) { FactoryGirl.create(:user) }
    before do
        @list = user.lists.build(title: "Grocery")
    end

    subject { @list }

    it { should respond_to(:title) }
    it { should respond_to(:user_id) }

    describe "access user_id" do
        it "should not allow" do
            expect { List.new(user_id: 2) }.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
        end
    end
    describe "association with user" do
        it { should respond_to(:user) }
        its(:user) { should == user }
    end
    describe "duplicate title" do
        before do
            dup_list = @list.dup
            dup_list.save
        end
        it { should_not be_valid }
    end

    describe "when user is is nil" do
        before { @list.user_id =nil }
        it { should_not be_valid }
    end

    describe "when title is more than 50 characters" do
        before { @list.title = "a"*51 }
        it { should_not be_valid }
    end

    describe "with empty title" do
        before { @list.title = "" }
        it { should_not be_valid }
    end
end
