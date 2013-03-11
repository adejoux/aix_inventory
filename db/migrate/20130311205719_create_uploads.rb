class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :upload_file_name
      t.string :upload_content_type
      t.integer :upload_file_size
      t.string :upload_updated_at

      t.timestamps
    end
  end
end
