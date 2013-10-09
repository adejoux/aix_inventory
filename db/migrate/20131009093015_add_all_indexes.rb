class AddAllIndexes < ActiveRecord::Migration
  def change
    add_index :activities, [ :trackable_id, :trackable_type ]
    add_index :aix_ports, [ :wwpn_id ]
    add_index :file_systems, [ :server_id ]
    add_index :health_checks, [ :server_id ]
    add_index :ip_addresses, [ :server_id ]
    add_index :linux_ports, [ :wwpn_id ]
    add_index :linux_security_fixes, [ :server_id ]
    add_index :lparstats, [ :server_id ]
    add_index :volume_groups, [ :server_id ]
    add_index :wwpns, [ :server_id ]
    add_index :wwpns, [ :san_infra_id ]
    add_index :report_fields, [ :report_id ]
    add_index :server_attributes, [ :server_id ]
    add_index :servers, [ :hardware_id ]
  end
end
