# == Schema Information
#
# Table name: lists
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  completed  :boolean          default(FALSE)
#

require 'spec_helper'

describe List do
    before { @list = List.create(title: "Sample Title 43534") }

    subject { @list }


    it { should respond_to(:title) }
    it { should respond_to(:completed) }

    describe "association with user" do
        let(:user) { FactoryGirl.create(:user, email: "yuv.slm@sample2453.com") }
        before do
            user.relationships.create(list_id: @list.id)
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
        let(:task) { FactoryGirl.create(:task, list_id: @list.id, order_number: 1 ) }

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
