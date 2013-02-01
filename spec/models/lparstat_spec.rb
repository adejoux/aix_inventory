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

require 'spec_helper'

describe Lparstat do
  it "has a valid factory" do
    FactoryGirl.create(:lparstat).should be_valid
  end
  it "is invalid without a partition_name" do
    FactoryGirl.build(:lparstat, partition_name: nil).should_not be_valid
  end
  it "is invalid without a mode" do
    FactoryGirl.build(:lparstat, mode: nil).should_not be_valid
  end
end
