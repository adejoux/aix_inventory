class RemovePropertiesToServers < ActiveRecord::Migration
  def up
    remove_column :servers, :properties
  end

  def down
    add_column :servers, :properties, :hstore
  end
end
