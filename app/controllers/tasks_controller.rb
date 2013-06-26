class TasksController < ApplicationController

    def create
        @names = params[:task][:content].split('@')
        @user = current_user
        @lists = current_user.lists
        begin
            if signed_in?
                if List.find_by_title(@names[1])
                    @list = List.find_by_title(@names[1])
                else
                    @list = List.create(title: @names[1])
                end
                rel = current_user.relationships.where(list_id: @list.id).first_or_initialize
                rel.save
                task = @list.tasks.create(content: @names[0])
            end
       
            respond_to do |format|
                format.js
            end
        rescue Exception => e
            respond_to do |format|
                format.js {  }
            end
        end
    end

    def destroy
        Task.find(params[:id]).destroy
        redirect_to '/'
    end

    def edit
        task = Task.find(params[:id])
        task.completed = !task.completed
        task.save
        redirect_to '/'
    end
end
