class CreateGroupsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
