class CreateWwpns < ActiveRecord::Migration
  def change
    create_table :wwpns do |t|
      t.integer :server_id
      t.integer :san_infra_id
      t.integer :sod_infra_id
      t.string :wwpn

      t.timestamps
    end
  end
end
