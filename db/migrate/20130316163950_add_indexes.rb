class AddIndexes < ActiveRecord::Migration
  def up
    add_index :servers, [ :customer, :hostname ], :unique => true
    add_index :aix_ports, [ :port, :wwpn ], :unique => true
    add_index :aix_paths, [ :server_id, :adapter ], :unique => true
    add_index :healthchecks, [ :server_id, :check ], :unique => true
  end

  def down
    remove_index :servers, [ :customer, :hostname ]
    remove_index :aix_ports, [ :port, :wwpn ]
    remove_index :aix_paths, [ :server_id, :adapter ]
    remove_index :healthchecks, [ :server_id, :check ]
  end
end
