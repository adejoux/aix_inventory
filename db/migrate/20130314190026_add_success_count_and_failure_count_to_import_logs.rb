class AddSuccessCountAndFailureCountToImportLogs < ActiveRecord::Migration
  def change
    add_column :import_logs, :success_count, :integer
    add_column :import_logs, :error_count, :integer
  end
end
