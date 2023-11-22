class RemoveReferenceFromPurchase < ActiveRecord::Migration[7.0]
  def change
    remove_reference :purchases, :course, null: false, foreign_key: true
  end
end
