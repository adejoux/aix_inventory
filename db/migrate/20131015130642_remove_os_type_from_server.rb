class RemoveOsTypeFromServer < ActiveRecord::Migration
  def change
    remove_column :servers, :os_type
  end
end
