require 'spec_helper'

describe "Tasks" do

    subject {page}

    describe "Toggle completed" do
        let(:user) { FactoryGirl.create(:user) }
        let(:list) { FactoryGirl.create(:list, user_id: user.id) }
        let(:task) { FactoryGirl.create(:task, list_id: list.id) }

        before do
            sign_in user
            visit '/'
        end

        describe "initially uncompleted" do
            it { find('div.uncompleted').should have_content(task.content) }
        end
        describe "after toggling" do
            before { visit edit_user(user.id) }

            it { find('div.completed').should have_content(task.content) }
        end
    end

end
