class CreateReportCustomers < ActiveRecord::Migration
  def change
    create_table :report_customers do |t|
      t.belongs_to :report
      t.belongs_to :customer

      t.timestamps
    end
    add_index :report_customers, :report_id
    add_index :report_customers, :customer_id
  end
end
