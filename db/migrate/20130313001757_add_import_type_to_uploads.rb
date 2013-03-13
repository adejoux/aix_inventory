class AddImportTypeToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :import_type, :string
  end
end
