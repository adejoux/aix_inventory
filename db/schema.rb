# -*- encoding : utf-8 -*-
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

ActiveRecord::Schema.define(:version => 20130125131115) do

  create_table "aix_paths", :force => true do |t|
    t.string   "adapter"
    t.string   "state"
    t.string   "mode"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "server_id"
    t.integer  "path"
  end

  add_index "aix_paths", ["server_id"], :name => "index_aix_paths_on_server_id"

  create_table "aix_ports", :force => true do |t|
    t.string   "port"
    t.string   "wwpn"
    t.integer  "server_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "aix_ports", ["server_id"], :name => "index_aix_ports_on_server_id"
  add_index "aix_ports", ["wwpn"], :name => "index_aix_ports_on_wwpn"

  create_table "firmwares", :force => true do |t|
    t.string   "model"
    t.string   "recommended"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "healthchecks", :force => true do |t|
    t.string   "check"
    t.string   "status"
    t.integer  "server_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "healthchecks", ["server_id"], :name => "index_healthchecks_on_server_id"

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

  create_table "servers", :force => true do |t|
    t.string   "customer"
    t.string   "hostname"
    t.string   "os_type"
    t.string   "os_version"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "sys_fwversion"
    t.string   "sys_serial"
    t.string   "sys_model"
    t.string   "global_image"
    t.string   "install_date"
    t.date     "run_date"
  end

  create_table "software_deployments", :force => true do |t|
    t.integer  "software_id"
    t.integer  "server_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "software_deployments", ["server_id"], :name => "index_software_deployments_on_server_id"
  add_index "software_deployments", ["software_id"], :name => "index_software_deployments_on_software_id"

  create_table "softwares", :force => true do |t|
    t.string   "name"
    t.string   "version"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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

end
