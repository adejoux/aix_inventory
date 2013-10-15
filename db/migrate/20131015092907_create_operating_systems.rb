class CreateOperatingSystems < ActiveRecord::Migration
  def change
    create_table :operating_systems do |t|
      t.string :version
      t.belongs_to :operating_system_type

      t.timestamps
    end
    add_index :operating_systems, :operating_system_type_id
  end
end
