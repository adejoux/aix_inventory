class RemoveServerIdFromHardwares < ActiveRecord::Migration
  def up
    remove_column :hardwares, :server_id
  end

  def down
    add_column :hardwares, :server_id, :integer
  end
end
