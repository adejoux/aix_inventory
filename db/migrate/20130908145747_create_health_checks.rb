class CreateHealthChecks < ActiveRecord::Migration
  def change
    create_table :health_checks do |t|
      t.string :name
      t.text :description
      t.integer :return_code
      t.text :output
      t.text :hc_errors
      t.integer :server_id

      t.timestamps
    end
  end
end
