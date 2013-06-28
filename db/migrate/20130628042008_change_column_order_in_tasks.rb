class ChangeColumnOrderInTasks < ActiveRecord::Migration
  def up
    rename_column :tasks, :order, :order_number
  end

  def down
    rename_column :tasks, :order_number, :order
  end
end
