class DropHealthcheck < ActiveRecord::Migration
  def up
    drop_table :healthchecks
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
