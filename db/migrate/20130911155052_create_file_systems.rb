class CreateFileSystems < ActiveRecord::Migration
  def change
    create_table :file_systems do |t|
      t.string :mount_point
      t.string :size
      t.string :free

      t.timestamps
    end
  end
end
