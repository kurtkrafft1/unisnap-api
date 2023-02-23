class AddStandardFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    # devise token_authenticatable
    add_column :users, :authentication_token, :text
    add_column :users, :authentication_token_created_at, :datetime
    add_index :users, :authentication_token, unique: true

    # devise trackable
    add_column :users, :sign_in_count, :integer, default: 0, null: false
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    # add_column :users, :current_sign_in_ip, :inet
    # add_column :users, :last_sign_in_ip, :inet

    # miscellaneous fields
    add_column :users, :administrator, :boolean, default: false, null: false
    add_column :users, :username, :string, :limit => 8
    add_column :users, :four_digit_id, :bigint, :limit => 4
  end
end
