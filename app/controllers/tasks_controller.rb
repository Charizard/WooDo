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
        @lists = current_user.lists
        begin
            if signed_in?
                task = Task.find(params[:id])
                move_after_destroy(List.find(task.list_id),task)
                flash.now[:success] = "Successfully deleted."
            end
            respond_to do |format|
                format.js
            end
        rescue Exception => e
            respond_to do |format|
                flash.now[:error] = e
                format.js
            end
        end
    end

    def edit
        task = Task.find(params[:id])
        task.completed = !task.completed
        task.save
        @lists = current_user.lists
        respond_to do |format|
            format.js
        end
    end
end
