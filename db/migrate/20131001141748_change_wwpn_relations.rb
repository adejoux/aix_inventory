class ChangeWwpnRelations < ActiveRecord::Migration
  def up
    remove_column :aix_ports, :server_id
    remove_column :linux_ports, :server_id
    add_column :wwpns, :san_infra_id, :integer
  end

  def down
    add_column :aix_ports, :server_id, :integer
    add_column :linux_ports, :server_id, :integer
    remove_column :wwpns, :san_infra_id
  end
end
