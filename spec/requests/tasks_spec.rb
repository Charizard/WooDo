require 'spec_helper'

describe "Tasks" do

    let(:user) { FactoryGirl.create(:user) }
    let!(:list) { FactoryGirl.create(:list) }
    let!(:task) { FactoryGirl.create(:task, content: "Chumma content", list_id: list.id, order_number: list.tasks.count + 1) }


    before do
        user.posses!(list)
        sign_in user
        visit '/'
    end

    subject {page}

    describe "Toggle completed" do

        describe "initially uncompleted" do
            it "should be incomplete" do
                find('ul.incomplete').should have_content(task.content)
            end
        end
        describe "after toggling" do
            before { click_link "task-edit" }

            it "should have", :js => true do
                find('ul.completed').should have_content(task.content)
            end
        end
    end

    describe "Task Deletion" do
        before do
            click_link "task-delete"
            page.driver.browser.switch_to.alert.accept
        end
        it "should display success", :js => true do
            should have_content("Successfully deleted")
        end
        it "should not display deleted task", :js => true do
            should_not have_content(task.content)
        end
    end

end
