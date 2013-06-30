class TasksController < ApplicationController
    include TasksHelper

    def create
        @names = params[:task][:content].split('@')
        @user = current_user
        @lists = current_user.lists
        begin
            if signed_in?
                if @lists.pluck(:title).include?(@names[1])
                    @list = @lists.find_by_title(@names[1])
                else
                    @list = List.create(title: @names[1])
                end
                rel = current_user.relationships.where(list_id: @list.id).first_or_initialize
                rel.save

                task = @list.tasks.create(content: @names[0], order_number: @list.tasks.count + 1 )
            end
      
            flash.now[:success] = "Created successfully."
            respond_to do |format|
                format.js
            end
        rescue Exception => e
            flash.now[:error] = "Syntax Error."
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
        rescue
            respond_to do |format|
                flash.now[:error] = "Could not delete."
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
