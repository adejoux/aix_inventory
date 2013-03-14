class CreateImportLogs < ActiveRecord::Migration
  def change
    create_table :import_logs do |t|
      t.integer :upload_id
      t.string :result
      t.text :content

      t.timestamps
    end
  end
end
