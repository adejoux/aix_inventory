class CreateLinuxPorts < ActiveRecord::Migration
  def change
    create_table :linux_ports do |t|
      t.string :name
      t.string :brand
      t.string :card_model
      t.string :card_type
      t.string :speed
      t.string :slot
      t.string :driver
      t.belongs_to :server

      t.timestamps
    end
  end
end
