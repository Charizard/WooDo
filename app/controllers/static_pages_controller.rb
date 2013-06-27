class StaticPagesController < ApplicationController
  def home
    if signed_in?
        @user = current_user 
        @lists = current_user.lists
        @task = Task.new
        @share = Relationship.new
    end
  end
end
