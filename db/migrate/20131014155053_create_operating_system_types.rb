class CreateOperatingSystemTypes < ActiveRecord::Migration
  def change
    create_table :operating_system_types do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
