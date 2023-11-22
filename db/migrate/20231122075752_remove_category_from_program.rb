class RemoveCategoryFromProgram < ActiveRecord::Migration[7.0]
  def change
    remove_reference :programs, :category, null: false, foreign_key: true
  end
end
