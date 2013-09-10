class CreateServerAttributes < ActiveRecord::Migration
  def change
    create_table :server_attributes do |t|
      t.string :name
      t.string :category
      t.text :description
      t.text :output
      t.text :conf_errors
      t.integer :return_code
      t.integer :server_id

      t.timestamps
    end
  end
end
