class RemoveColumnFromProgram < ActiveRecord::Migration[7.0]
  def change
    remove_column :programs, :video, :string
  end
end
