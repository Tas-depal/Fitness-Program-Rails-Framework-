class AddUserRefernceToProgram < ActiveRecord::Migration[7.0]
  def change
    add_reference :programs, :user, null: false, foreign_key: true
  end
end
