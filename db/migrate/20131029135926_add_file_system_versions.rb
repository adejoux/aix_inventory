class AddFileSystemVersions < ActiveRecord::Migration
  def up
     create_table "file_system_versions", :force => true do |t|
      t.string   "item_type",      :null => false
      t.integer  "item_id",        :null => false
      t.string   "event",          :null => false
      t.string   "whodunnit"
      t.text     "object"
      t.text     "object_changes"
      t.datetime "created_at"
    end

    add_index "file_system_versions", ["item_type", "item_id"], :name => "index_file_system_versions_on_item_type_and_item_id"
  end

  def down
    drop_table :file_system_versions
    drop_index :index_file_system_versions_on_item_type_and_item_id
  end
end
