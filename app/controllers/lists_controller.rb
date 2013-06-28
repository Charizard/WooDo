class ListsController < ApplicationController
    include ListsHelper

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
        @lists = current_user.lists
        respond_to do |format|
            format.js
        end
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
        rescue
            flash.now[:error] = "Cannot share."
            respond_to do |format|
               format.js
            end
        end
    end
=begin
    def reorder
        @lists = current_user.lists
        #begin
            @from_list_id = params[from_list_id]
            @from_order_number = params[from_order_number]
            @to_list_id = params[to_list_id]
            @to_order_number = params[to_order_number]
            if @from_list_id == @to_list_id do
                rearrange_within_list @from_list_id, @from_order_number, @to_order_number
            end

            flash.now[:success] = "Successfully reordered."

            #respond_to do |format|
            #    format.js
            #end
        #rescue Exception => e
         #   flash.now[:error] = e

          #  respond_to do |format|
           #     format.js
            #end
        end
    end
=end

end