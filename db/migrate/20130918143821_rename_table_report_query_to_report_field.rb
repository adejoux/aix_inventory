class RenameTableReportQueryToReportField < ActiveRecord::Migration
  def change
    rename_table :report_queries, :report_fields
  end
end
