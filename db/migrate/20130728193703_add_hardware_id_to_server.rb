class AddHardwareIdToServer < ActiveRecord::Migration
  def change
    add_column :servers, :hardware_id, :integer
  end
end
