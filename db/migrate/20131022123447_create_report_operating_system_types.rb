class CreateReportOperatingSystemTypes < ActiveRecord::Migration
  def change
    create_table :report_operating_system_types do |t|
      t.belongs_to :report
      t.belongs_to :operating_system_type

      t.timestamps
    end
    add_index :report_operating_system_types, :report_id
    add_index :report_operating_system_types, :operating_system_type_id
  end
end
