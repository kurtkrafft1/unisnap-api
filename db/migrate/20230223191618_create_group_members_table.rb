class CreateGroupMembersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :group_members do |t|
      t.integer :group_id, null: false
      t.integer :user_id, null: false
    end
  end
end
