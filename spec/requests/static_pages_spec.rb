require 'spec_helper'

describe "StaticPages" do
    
    subject { page }
    
    describe "Home Page" do
        before { visit '/static_pages/home' }

        it { should have_selector('h1', text: 'Woo Do') }
        it { should have_selector('title', text: 'Woo Do | Save Tasks') }
        it { should have_link('Sign up') }
        
        describe "after signin" do
            let(:user) { FactoryGirl.create(:user) }
            let!(:list) { FactoryGirl.create(:list, title: "List Name") }
            let!(:task) { FactoryGirl.create(:task, list_id: list.id) }
            before do
                user.posses!(list)
                sign_in user
            end

            it { should have_content(list.title) }
            it { should have_content(task.content) }
            it { should have_link('delete') }

            describe "List Deletion" do
                it "should delete list" do
                    expect { click_link "delete" }.to change(List, :count).by(-1)
                end
                it " should also delete tasks" do
                    expect { click_link "delete" }.to change(Task, :count).by(list.tasks.count*-1)
                end
            end

            describe "Task Deletion" do
                it "should delete task" do
                    expect { find('#task-delete').click }.to change(Task, :count).by(-1)
                end
            end
        end
    end
end
