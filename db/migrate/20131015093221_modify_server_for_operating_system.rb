class ModifyServerForOperatingSystem < ActiveRecord::Migration
  def up
    remove_column :servers, :os_version
    add_column :servers, :operating_system_id, :integer
    add_index :servers, :operating_system_id
  end

  def down
    add_column :servers, :os_version
    remove_column :servers, :operating_system_id, :integer
    remove_index :servers, :operating_system_id
  end
end
