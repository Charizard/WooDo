# == Schema Information
#
# Table name: relationships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  list_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Relationship do
  let(:user) { FactoryGirl.create(:user) }
  let(:list) { FactoryGirl.create(:list) }
  let(:relationship) { user.relationships.build(list_id: list.id) }
  subject { relationship }

  it { should be_valid }

  describe "Access to list_id" do
    it "should not allow access to list.id" do
        expect do
            Relationship.new(user_id: user.id)
        end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { relationship.user_id = nil }
    it { should_not be_valid }
  end
  describe "when list_id is not present" do
    before { relationship.list_id =nil }
    it { should_not be_valid }
  end
end
