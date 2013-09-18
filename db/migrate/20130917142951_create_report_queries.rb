class CreateReportQueries < ActiveRecord::Migration
  def change
    create_table :report_fields do |t|
      t.string :association_type
      t.string :select_attribute
      t.string :report_id

      t.timestamps
    end
  end
end
