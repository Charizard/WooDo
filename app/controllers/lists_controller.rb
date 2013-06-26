class ListsController < ApplicationController
    def create
    end

    def edit
        list = List.find(params[:id])
        list.completed = !list.completed
        list.tasks.each do |task|
            task.completed = list.completed
            task.save
        end
        list.save
        redirect_to '/'
    end

    def show
        if signed_in?
            @user = current_user
            @lists = @user.lists
        end
    end

    def destroy
        List.find(params[:id]).destroy
        redirect_to '/'
    end

    def complete
        task = Task.find(params[:id])
        task.completed =true
    end
end
