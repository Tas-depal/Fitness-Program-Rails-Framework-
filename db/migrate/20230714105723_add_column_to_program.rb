class AddColumnToProgram < ActiveRecord::Migration[7.0]
  def change
    add_column :programs, :video, :binary
  end
end
