class RemoveDeviseColumnsFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :encrypted_password, :string
    remove_column :users, :reset_password_token, :string
    remove_column :users, :reset_password_sent_at, :datetime
    remove_column :users, :remember_created_at, :datetime
    remove_column :users, :jti
    remove_column :users, :uid
    remove_column :users, :provider
    remove_index :users, :email
    add_column :users, :password_digest, :string
  end
end
