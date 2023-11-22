class CreatePrograms < ActiveRecord::Migration[7.0]
  def change
    create_table :programs do |t|
      t.string :name
      t.string :status
      t.integer :price
      t.binary :video

      t.timestamps
    end
  end
end
