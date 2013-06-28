class AddIndexToTask < ActiveRecord::Migration
  def change
  end
  add_index :tasks, [:list_id,:order], unique: true
end
