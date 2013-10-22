# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131022165527) do

  create_table "activities", :force => true do |t|
    t.string   "action"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "activities", ["trackable_id", "trackable_type"], :name => "index_activities_on_trackable_id_and_trackable_type"
  add_index "activities", ["trackable_id"], :name => "index_activities_on_trackable_id"

  create_table "aix_alerts", :force => true do |t|
    t.string   "alert_type"
    t.string   "check"
    t.string   "valid_status"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "aix_paths", :force => true do |t|
    t.string   "adapter"
    t.string   "state"
    t.string   "mode"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "server_id"
    t.integer  "path"
  end

  add_index "aix_paths", ["server_id", "adapter"], :name => "index_aix_paths_on_server_id_and_adapter", :unique => true
  add_index "aix_paths", ["server_id"], :name => "index_aix_paths_on_server_id"

  create_table "aix_ports", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "wwpn_id"
  end

  add_index "aix_ports", ["wwpn_id"], :name => "index_aix_ports_on_wwpn_id"

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "file_systems", :force => true do |t|
    t.string   "mount_point"
    t.string   "size"
    t.string   "free"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "server_id"
    t.string   "device"
  end

  add_index "file_systems", ["server_id", "mount_point"], :name => "index_file_systems_on_server_id_and_mount_point", :unique => true
  add_index "file_systems", ["server_id"], :name => "index_file_systems_on_server_id"

  create_table "firmwares", :force => true do |t|
    t.string   "model"
    t.string   "recommended"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "hardwares", :force => true do |t|
    t.string   "sys_model"
    t.string   "firmware"
    t.string   "serial"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "health_checks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "return_code"
    t.text     "output"
    t.text     "hc_errors"
    t.integer  "server_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "info"
  end

  add_index "health_checks", ["server_id"], :name => "index_health_checks_on_server_id"

  create_table "healthcheck_versions", :force => true do |t|
    t.string   "item_type",      :null => false
    t.integer  "item_id",        :null => false
    t.string   "event",          :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.text     "object_changes"
    t.datetime "created_at"
  end

  add_index "healthcheck_versions", ["item_type", "item_id"], :name => "index_healthcheck_versions_on_item_type_and_item_id"

  create_table "import_logs", :force => true do |t|
    t.integer  "upload_id"
    t.string   "result"
    t.text     "content"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "success_count"
    t.integer  "error_count"
  end

  create_table "import_reports", :force => true do |t|
    t.string   "filename"
    t.string   "result"
    t.text     "output"
    t.integer  "success_count"
    t.integer  "error_count"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "ip_addresses", :force => true do |t|
    t.string   "address"
    t.string   "subnet"
    t.string   "mac_address"
    t.integer  "server_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "ip_addresses", ["server_id"], :name => "index_ip_addresses_on_server_id"

  create_table "linux_ports", :force => true do |t|
    t.string   "name"
    t.string   "brand"
    t.string   "card_model"
    t.string   "card_type"
    t.string   "speed"
    t.string   "slot"
    t.string   "driver"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "wwpn_id"
    t.string   "firmware"
  end

  add_index "linux_ports", ["wwpn_id"], :name => "index_linux_ports_on_wwpn_id"

  create_table "linux_security_fixes", :force => true do |t|
    t.string   "name"
    t.string   "severity"
    t.string   "rhsa"
    t.string   "category"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "server_id"
  end

  add_index "linux_security_fixes", ["server_id"], :name => "index_linux_security_fixes_on_server_id"

  create_table "lparstat_versions", :force => true do |t|
    t.string   "item_type",      :null => false
    t.integer  "item_id",        :null => false
    t.string   "event",          :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.text     "object_changes"
    t.datetime "created_at"
  end

  add_index "lparstat_versions", ["item_type", "item_id"], :name => "index_lparstat_versions_on_item_type_and_item_id"

  create_table "lparstats", :force => true do |t|
    t.string   "node_name"
    t.string   "partition_name"
    t.integer  "partition_number"
    t.float    "entitled_capacity"
    t.integer  "partition_group"
    t.integer  "shared_pool"
    t.integer  "online_virtual_cpus"
    t.integer  "maximum_virtual_cpus"
    t.integer  "minimum_virtual_cpus"
    t.string   "online_memory"
    t.string   "maximum_memory"
    t.string   "minimum_memory"
    t.integer  "variable_capacity_weight"
    t.float    "minimum_capacity"
    t.float    "maximum_capacity"
    t.float    "capacity_increment"
    t.integer  "maximum_physical_cpus_in_system"
    t.integer  "active_physical_cpus_in_system"
    t.integer  "active_cpus_in_pool"
    t.integer  "shared_physical_cpus_in_system"
    t.float    "maximum_capacity_of_pool"
    t.float    "entitled_capacity_of_pool"
    t.float    "unallocated_capacity"
    t.float    "physical_cpu_percentage"
    t.float    "unallocated_weight"
    t.string   "memory_mode"
    t.string   "variable_memory_capacity_weight"
    t.string   "memory_pool"
    t.string   "physical_memory_in_the_pool"
    t.string   "hypervisor_page_size"
    t.string   "unallocated_variable_memory_capacity_weight"
    t.string   "unallocated_io_memory_entitlement"
    t.string   "memory_group_id_of_lpar"
    t.integer  "desired_virtual_cpus"
    t.string   "desired_memory"
    t.float    "desired_variable_capacity_weight"
    t.float    "desired_capacity"
    t.string   "target_memory_expansion_factor"
    t.string   "target_memory_expansion_size"
    t.string   "power_saving_mode"
    t.integer  "server_id"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "mode"
    t.string   "total_io_memory_entitlement"
    t.string   "lpar_type"
  end

  add_index "lparstats", ["server_id"], :name => "index_lparstats_on_server_id"

  create_table "operating_system_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "operating_systems", :force => true do |t|
    t.string   "release"
    t.integer  "operating_system_type_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "operating_systems", ["operating_system_type_id"], :name => "index_operating_systems_on_operating_system_type_id"

  create_table "report_customers", :force => true do |t|
    t.integer  "report_id"
    t.integer  "customer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "report_customers", ["customer_id"], :name => "index_report_customers_on_customer_id"
  add_index "report_customers", ["report_id"], :name => "index_report_customers_on_report_id"

  create_table "report_fields", :force => true do |t|
    t.string   "association_type"
    t.string   "select_attribute"
    t.string   "report_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "report_fields", ["report_id"], :name => "index_report_fields_on_report_id"

  create_table "report_operating_system_types", :force => true do |t|
    t.integer  "report_id"
    t.integer  "operating_system_type_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "report_operating_system_types", ["operating_system_type_id"], :name => "index_report_operating_system_types_on_operating_system_type_id"
  add_index "report_operating_system_types", ["report_id"], :name => "index_report_operating_system_types_on_report_id"

  create_table "reports", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
    t.string   "report_type"
  end

  create_table "san_alerts", :force => true do |t|
    t.string   "alert_type"
    t.string   "fabric1"
    t.string   "fabric2"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "san_infras", :force => true do |t|
    t.string   "infra",      :limit => 15
    t.string   "fabric",     :limit => 15
    t.string   "switch",     :limit => 30
    t.string   "port",       :limit => 10
    t.string   "speed",      :limit => 5
    t.string   "status",     :limit => 15
    t.string   "portname",   :limit => 30
    t.string   "mode",       :limit => 15
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "server_attributes", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.text     "description"
    t.text     "output"
    t.text     "conf_errors"
    t.integer  "return_code"
    t.integer  "server_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "server_attributes", ["server_id", "name"], :name => "index_server_attributes_on_server_id_and_name", :unique => true
  add_index "server_attributes", ["server_id"], :name => "index_server_attributes_on_server_id"

  create_table "server_versions", :force => true do |t|
    t.string   "item_type",      :null => false
    t.integer  "item_id",        :null => false
    t.string   "event",          :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "server_versions", ["item_type", "item_id"], :name => "index_server_versions_on_item_type_and_item_id"

  create_table "servers", :force => true do |t|
    t.string   "hostname"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.date     "run_date"
    t.integer  "hardware_id"
    t.integer  "customer_id"
    t.integer  "operating_system_type_id"
    t.integer  "operating_system_id"
  end

  add_index "servers", ["hardware_id"], :name => "index_servers_on_hardware_id"
  add_index "servers", ["hostname"], :name => "index_servers_on_customer_and_hostname", :unique => true
  add_index "servers", ["operating_system_id"], :name => "index_servers_on_operating_system_id"

  create_table "software_deployment_versions", :force => true do |t|
    t.string   "item_type",      :null => false
    t.integer  "item_id",        :null => false
    t.string   "event",          :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.text     "object_changes"
    t.datetime "created_at"
  end

  add_index "software_deployment_versions", ["item_type", "item_id"], :name => "index_software_deployment_versions_on_item_type_and_item_id"

  create_table "switch_ports", :force => true do |t|
    t.string   "fabric"
    t.string   "domain"
    t.string   "port"
    t.string   "wwpn"
    t.string   "port_alias"
    t.integer  "aix_port_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "switch_ports", ["aix_port_id"], :name => "index_switch_ports_on_san_port_id"
  add_index "switch_ports", ["wwpn"], :name => "index_switch_ports_on_wwpn"

  create_table "uploads", :force => true do |t|
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.string   "upload_updated_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "import_type"
    t.string   "workflow_state"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "username"
    t.boolean  "approved",               :default => false, :null => false
    t.string   "role"
    t.string   "customer_scope"
  end

  add_index "users", ["approved"], :name => "index_users_on_approved"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "volume_groups", :force => true do |t|
    t.string   "name"
    t.string   "vg_size"
    t.string   "free_size"
    t.integer  "server_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "volume_groups", ["server_id"], :name => "index_volume_groups_on_server_id"

  create_table "wwpns", :force => true do |t|
    t.string   "wwpn"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "server_id"
    t.integer  "san_infra_id"
  end

  add_index "wwpns", ["san_infra_id"], :name => "index_wwpns_on_san_infra_id"
  add_index "wwpns", ["server_id"], :name => "index_wwpns_on_server_id"

end
