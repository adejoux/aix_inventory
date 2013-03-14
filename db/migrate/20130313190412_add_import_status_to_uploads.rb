class AddImportStatusToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :workflow_state, :string
  end
end
