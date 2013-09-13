class CreateIpAddresses < ActiveRecord::Migration
  def change
    create_table :ip_addresses do |t|
      t.string :address
      t.string :subnet
      t.string :mac_address
      t.integer :server_id

      t.timestamps
    end
  end
end
