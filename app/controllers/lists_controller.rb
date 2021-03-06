class ListsController < ApplicationController
    include ListsHelper

    def create
    end
  
    def complete
        list = List.find(params[:id])
        list.complete!
    end

    def edit
        list = List.find(params[:id])
        list.completed = !list.completed
        list.tasks.each do |task|
            task.completed = list.completed
            task.save
        end
        list.save
        @lists = current_user.lists
        respond_to do |format|
            format.js
        end
    end

    def show
        if signed_in?
            @user = current_user
            @lists = @user.lists
        end
    end

    def destroy
        List.find(params[:id]).destroy
        render :json => {}.to_json;
    end

    def share
        begin
            @lists = current_user.lists
            user = User.find_by_email(params[:list][:user][:email])
            list = List.find(params[:list_id])
            user.relationships.create(list_id: list.id)

            flash.now[:success] = "Successfully shared to #{params[:list][:user][:email]}"
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

    def update
        @list = List.find(params[:id])
        @list.update_attributes!(completed: params[:completed])
        render :json => {}.to_json
    end
end
