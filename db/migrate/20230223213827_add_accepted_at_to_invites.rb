class AddAcceptedAtToInvites < ActiveRecord::Migration[6.0]
  def change
    change_table :invites do |t|
      t.datetime :accepted_at, null: true
    end
  end
end
