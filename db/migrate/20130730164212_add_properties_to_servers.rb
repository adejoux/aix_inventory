class AddPropertiesToServers < ActiveRecord::Migration
  def up
    add_column :servers, :properties, :hstore
    execute "CREATE INDEX servers_properties ON servers USING GIN(properties)"
  end

  def down
    execute "DROP INDEX servers_properties"
  end
end
