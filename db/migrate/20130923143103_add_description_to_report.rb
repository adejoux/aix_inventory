class AddDescriptionToReport < ActiveRecord::Migration
  def change
    add_column :reports, :description, :string
    add_column :reports, :report_type, :string
  end
end
