class AddReferenceToPurchase < ActiveRecord::Migration[7.0]
  def change
    add_reference :purchases, :program, null: false, foreign_key: true
  end
end
