class RemoveColumnFromProgramModel < ActiveRecord::Migration[7.0]
  def change
    remove_column :programs, :video, :binary
  end
end
