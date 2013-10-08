class AddNewIndexes < ActiveRecord::Migration
  def change
    add_index :file_systems, [:server_id, :mount_point], unique: true
    add_index :server_attributes, [:server_id, :name], unique: true
  end
end
