class RenameVersionToRelease < ActiveRecord::Migration
  def change
    rename_column :operating_systems, :version, :release
  end
end
