class AddServerIdToFileSystems < ActiveRecord::Migration
  def change
    add_column :file_systems, :server_id, :integer
  end
end
