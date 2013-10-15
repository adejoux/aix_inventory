class ModifyServer < ActiveRecord::Migration
  def up
    remove_column :servers, :customer
    add_column :servers, :customer_id, :integer
    add_column :servers, :operating_system_type_id, :integer
  end
  def down
    add_column :servers, :customer, :string
    remove_column :servers, :customer_id
    remove_column :servers, :operating_system_type_id
  end
end
