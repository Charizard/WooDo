require 'spec_helper'

describe List do
    before { @list = List.create(title: "Sample Title") }

    subject { @list }


    it { should respond_to(:title) }
    it { should respond_to(:completed) }

    describe "association with user" do
        let(:user) { FactoryGirl.create(:user) }
        before do
            @list.save
            rel = user.relationships.build(list_id: @list.id)
            rel.save
        end
        it { should respond_to(:users) }
        its(:users) { should include(user) }
    end

    describe "when title is nil" do
        before { @list.title =nil }
        it { should_not be_valid }
    end

    describe "when title is more than 20 characters" do
        before { @list.title = "a"*21 }
        it { should_not be_valid }
    end

    describe "with empty title" do
        before { @list.title = "" }
        it { should_not be_valid }
    end
    
    describe "association with Task" do
        let(:task) { FactoryGirl.create(:task, list_id: @list.id) }

        it { should respond_to(:tasks) }
        its(:tasks) { should include(task) }
    end
    
    describe "incomplete" do
        it { should_not be_completed }

        describe "toggling" do
            before { @list.completed = true }
            it { should be_completed }
        end
    end
end
