require 'spec_helper'

describe "Tasks" do

    subject {page}

    describe "Toggle completed" do
        let(:user) { FactoryGirl.create(:user) }
        let!(:list) { FactoryGirl.create(:list, title: "Sample List") }
        let!(:task) { FactoryGirl.create(:task, list_id: list.id, order_number: List.tasks.count + 1) }

        before do
            user.posses!(list)
            sign_in user
            visit '/'
        end

        describe "initially uncompleted" do
            it "enable js", :js => true do
                find('ul.incomplete').should have_content(task.content)
            end
        end
        describe "after toggling" do
            before { visit edit_task_url(task.id) }

            it { find('ul.completed').should have_content(task.content) }
        end
    end

end
