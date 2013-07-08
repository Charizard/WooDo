class TasksController < ApplicationController
    include TasksHelper

    def create
        task, list = params[:task][:content].split('@')
        @user = current_user
        @lists = current_user.lists
        begin
            create_task_and_list task, list
      
            flash.now[:success] = "Created successfully."
            respond_to do |format|
                format.js
            end
        rescue Exception => e
            flash.now[:error] = e
            respond_to do |format|
                format.js
            end
        end
    end

    def destroy
        task = Task.find(params[:id])
        move_after_destroy(List.find(task.list_id),task)
        render :json => {}.to_json
    end

    def update
        @task = Task.find(params[:id])
        @task.update_attributes!(params[:task])
        render :json => @task.to_json
    end
end
