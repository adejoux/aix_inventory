class RemoveWwpnFromAixPorts < ActiveRecord::Migration
  def change
    remove_index :aix_ports, :name => :index_aix_ports_on_port_and_wwpn
    remove_index :aix_ports, :name => :index_aix_ports_on_wwpn
    remove_column :aix_ports, :wwpn
  end
end
