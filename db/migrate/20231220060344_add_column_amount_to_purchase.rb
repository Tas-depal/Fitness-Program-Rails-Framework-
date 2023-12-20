class AddColumnAmountToPurchase < ActiveRecord::Migration[7.0]
  def change
    add_column :purchases, :amount, :integer
  end
end
