class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :list_id

      t.timestamps
    end
    add_index :relationships, :user_id
    add_index :relationships, :list_id
    add_index :relationships, [:user_id, :list_id], unique: true
  end
end
