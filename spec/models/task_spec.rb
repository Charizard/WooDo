require 'spec_helper'

describe Task do

  let(:user) { FactoryGirl.create(:user) }
  let(:list) { FactoryGirl.create(:list) }

  before do
    rel = user.relationships.build(list_id: list.id)
    rel.save
    @task = list.tasks.build(content: "Sample Task") 
  end

  subject { @task }


  it { should respond_to(:content) }
  it { should respond_to(:list) }

  describe "task content should not be" do
    describe "blank" do
        before { @task.content = "" }
        it { should_not be_valid }
    end
    describe "nil" do
        before { @task.content = nil }
        it { should_not be_valid }
    end
    describe "longer than 30 characters" do
        before { @task.content = "a"*31 }
        it { should_not be_valid }
    end
  end

  describe "Access to list_id" do
    it "should not allow access" do
        expect do
            Task.create(list_id: list.id)
        end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "association with list" do
    it { should respond_to(:list) }
    its(:list) { should == list }
  end
end
