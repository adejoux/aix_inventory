class AddDeviceToFilesystems < ActiveRecord::Migration
  def change
    add_column :file_systems, :device, :string
  end
end
