class AddFirmwareToLinuxPort < ActiveRecord::Migration
  def change
    add_column :linux_ports, :firmware, :string
  end
end
