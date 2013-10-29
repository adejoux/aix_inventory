class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.string :status
      t.string :location
      t.string :description
      t.belongs_to :server

      t.timestamps
    end
    add_index :devices, :server_id
  end
end
