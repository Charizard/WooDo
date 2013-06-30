class RemoveIndexFromTasks < ActiveRecord::Migration
  def change
  	remove_index :tasks, [:list_id,:order]
  end
end
