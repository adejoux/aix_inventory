class CreateHardwares < ActiveRecord::Migration
  def change
    create_table :hardwares do |t|
      t.string :sys_model
      t.string :firmware
      t.string :serial
      t.integer :server_id

      t.timestamps
    end
  end
end
