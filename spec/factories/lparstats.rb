# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lparstat do
    node_name "MyString"
    partition_name "MyString"
    mode "MyString"
    partition_number 1
    entitled_capacity 1
    partition_group 1
    shared_pool 1
    online_virtual_cpus 1
    maximum_virtual_cpus 1
    minimum_virtual_cpus 1
    online_memory "MyString"
    maximum_memory "MyString"
    minimum_memory "MyString"
    variable_capacity_weight 1
    minimum_capacity 1
    maximum_capacity 1
    capacity_increment 1
    maximum_physical_cpus_in_system 1
    active_physical_cpus_in_system 1
    active_cpus_in_pool 1
    shared_physical_cpus_in_system 1
    maximum_capacity_of_pool 1
    entitled_capacity_of_pool 1
    unallocated_capacity 1
    physical_cpu_percentage 1
    unallocated_weight 1
    memory_mode "MyString"
    variable_memory_capacity_weight "MyString"
    memory_pool "MyString"
    physical_memory_in_the_pool "MyString"
    hypervisor_page_size "MyString"
    unallocated_variable_memory_capacity_weight "MyString"
    unallocated_io_memory_entitlement "MyString"
    memory_group_id_of_lpar "MyString"
    desired_virtual_cpus 1
    desired_memory "MyString"
    desired_variable_capacity_weight 1
    desired_capacity 1
    target_memory_expansion_factor "MyString"
    target_memory_expansion_size "MyString"
    power_saving_mode "MyString"
    server_id 1
  end
end
