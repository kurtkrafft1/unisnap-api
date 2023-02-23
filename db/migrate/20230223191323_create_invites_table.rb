class CreateInvitesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :invites do |t|
      t.integer :group_id, null: false
      t.integer :user_id, null: false
      t.integer :inviter_id, null: false
      t.timestamps
    end
  end
end
