# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: lparstats
#
#  id                                          :integer          not null, primary key
#  node_name                                   :string(255)
#  partition_name                              :string(255)
#  partition_number                            :integer
#  entitled_capacity                           :float
#  partition_group                             :integer
#  shared_pool                                 :integer
#  online_virtual_cpus                         :integer
#  maximum_virtual_cpus                        :integer
#  minimum_virtual_cpus                        :integer
#  online_memory                               :string(255)
#  maximum_memory                              :string(255)
#  minimum_memory                              :string(255)
#  variable_capacity_weight                    :integer
#  minimum_capacity                            :float
#  maximum_capacity                            :float
#  capacity_increment                          :float
#  maximum_physical_cpus_in_system             :integer
#  active_physical_cpus_in_system              :integer
#  active_cpus_in_pool                         :integer
#  shared_physical_cpus_in_system              :integer
#  maximum_capacity_of_pool                    :float
#  entitled_capacity_of_pool                   :float
#  unallocated_capacity                        :float
#  physical_cpu_percentage                     :float
#  unallocated_weight                          :float
#  memory_mode                                 :string(255)
#  variable_memory_capacity_weight             :string(255)
#  memory_pool                                 :string(255)
#  physical_memory_in_the_pool                 :string(255)
#  hypervisor_page_size                        :string(255)
#  unallocated_variable_memory_capacity_weight :string(255)
#  unallocated_io_memory_entitlement           :string(255)
#  memory_group_id_of_lpar                     :string(255)
#  desired_virtual_cpus                        :integer
#  desired_memory                              :string(255)
#  desired_variable_capacity_weight            :float
#  desired_capacity                            :float
#  target_memory_expansion_factor              :string(255)
#  target_memory_expansion_size                :string(255)
#  power_saving_mode                           :string(255)
#  server_id                                   :integer
#  created_at                                  :datetime         not null
#  updated_at                                  :datetime         not null
#  mode                                        :string(255)
#  total_io_memory_entitlement                 :string(255)
#  lpar_type                                   :string(255)
#

class Lparstat < ActiveRecord::Base
  belongs_to :server
  attr_accessible :active_cpus_in_pool, :active_physical_cpus_in_system, :capacity_increment, :desired_capacity, :desired_memory, :desired_variable_capacity_weight, :desired_virtual_cpus, :entitled_capacity, :entitled_capacity_of_pool, :hypervisor_page_size, :maximum_capacity, :maximum_capacity_of_pool, :maximum_memory, :maximum_physical_cpus_in_system, :maximum_virtual_cpus, :memory_group_id_of_lpar, :memory_mode, :memory_pool, :minimum_capacity, :minimum_memory, :minimum_virtual_cpus, :node_name, :online_memory, :online_virtual_cpus, :partition_group, :partition_name, :partition_number, :physical_cpu_percentage, :physical_memory_in_the_pool, :power_saving_mode, :server_id, :shared_physical_cpus_in_system, :shared_pool, :target_memory_expansion_factor, :target_memory_expansion_size, :unallocated_capacity, :unallocated_io_memory_entitlement, :unallocated_variable_memory_capacity_weight, :unallocated_weight, :variable_capacity_weight, :variable_memory_capacity_weight, :mode, :type, :total_io_memory_entitlement

  validates_presence_of :partition_name, :mode
  
  scope :scoped_customer,   lambda { |customer| { 
      :joins => "INNER JOIN servers ON servers.id = lparstats.server_id",
      :conditions => ["servers.customer LIKE ?", "%#{customer}%"]
      }
  }
  
  has_paper_trail :class_name => 'LparstatVersion'

  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "id", "server_id"]
  
  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
