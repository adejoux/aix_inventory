class CreateImportReports < ActiveRecord::Migration
  def change
    create_table :import_reports do |t|
      t.string :filename
      t.string :result
      t.text :output
      t.integer :success_count
      t.integer :error_count

      t.timestamps
    end
  end
end
