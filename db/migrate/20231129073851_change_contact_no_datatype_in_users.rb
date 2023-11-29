class ChangeContactNoDatatypeInUsers < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :contact_no, :string
  end
  def down
    change_column :users, :contact_no, :integer
  end
end
