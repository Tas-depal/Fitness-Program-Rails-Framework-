class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :purchase, null: false, foreign_key: true
      t.string :stripe_id

      t.timestamps
    end
  end
end
