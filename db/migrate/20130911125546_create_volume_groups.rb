class CreateVolumeGroups < ActiveRecord::Migration
  def change
    create_table :volume_groups do |t|
      t.string :name
      t.string :vg_size
      t.string :free_size
      t.integer :server_id

      t.timestamps
    end
  end
end
