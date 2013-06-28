class TasksController < ApplicationController

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
                task = @list.tasks.create(content: @names[0])
            end
      
            flash.now[:success] = "Created successfully."
            respond_to do |format|
                format.js
            end
        rescue Exception => e
            flash.now[:error] = "Invalid Command"
            respond_to do |format|
                format.js
            end
        end
    end

    def destroy
        Task.find(params[:id]).destroy
        @lists = current_user.lists
        respond_to do |format|
            format.js
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
