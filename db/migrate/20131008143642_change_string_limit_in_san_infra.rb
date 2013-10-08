class ChangeStringLimitInSanInfra < ActiveRecord::Migration
  def up
    change_column :san_infras, :portname, :string, :limit => 30
    change_column :san_infras, :switch, :string, :limit => 30
  end

  def down
    change_column :san_infras, :portname, :string, :limit => 15
    change_column :san_infras, :switch, :string, :limit => 15
  end
end
