class ModifyWwpnRelations < ActiveRecord::Migration
  def up
    remove_column :wwpns, :aix_port_id
    remove_column :wwpns, :san_infra_id
    remove_column :wwpns, :sod_infra_id
    add_column :wwpns, :server_id, :integer
    add_column :linux_ports, :wwpn_id, :integer
    add_column :aix_ports, :wwpn_id, :integer
  end

  def down
    add_column :wwpns, :aix_port_id, :integer
    add_column :wwpns, :san_infra_id, :integer
    add_column :wwpns, :sod_infra_id, :integer
    remove_column :wwpns, :server_id
    remove_column :linux_ports, :wwpn_id
    remove_column :aix_ports, :wwpn_id

  end
end
