class RenamePortInAixPort < ActiveRecord::Migration
  def change
    rename_column :aix_ports, :port, :name
  end
end
