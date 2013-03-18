class CreateSanInfras < ActiveRecord::Migration
  def change
    create_table :san_infras do |t|
      t.string :infra, :limit => 15
      t.string :fabric, :limit => 15
      t.string :switch, :limit => 15
      t.string :port, :limit => 10
      t.string :speed, :limit => 5
      t.string :status, :limit => 15
      t.string :portname, :limit => 15
      t.string :mode, :limit => 15

      t.timestamps
    end
  end
end
