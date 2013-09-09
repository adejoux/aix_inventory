class AddInfoToHealthCheck < ActiveRecord::Migration
  def change
    add_column :health_checks, :info, :text
  end
end
