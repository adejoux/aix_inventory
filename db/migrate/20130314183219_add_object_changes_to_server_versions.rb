class AddObjectChangesToServerVersions < ActiveRecord::Migration
  def change
    add_column :server_versions, :object_changes, :text
  end
end
