# -*- encoding : utf-8 -*-
class Import < Thor
  require './config/environment'
  require 'smarter_csv'
  
  desc "clear", "clear csv data from csv file"
  def clear
      Server.delete_all
      Lparstat.delete_all
      Healthcheck.delete_all
      SwitchPort.delete_all
      AixPort.delete_all
      AixPath.delete_all
      Software.delete_all
      SoftwareDeployment.delete_all
  end
 
  desc "san_csv", "upload switch ports from csv file"
  def san_csv(filename)
     total_chunks = SmarterCSV.process(filename, :chunk_size => 500, :col_sep => ";") do |chunk|
      SwitchPort.transaction do
        chunk.each do |entry|
          next if entry[:wwpn].nil?
          port = SwitchPort.new
          port.fabric = entry[:fabric]
          if entry[:wwpn] =~ /:/
            port.wwpn = entry[:wwpn].gsub(':', '').upcase
          elsif entry[:wwpn].is_a? Integer
            port.wwpn = entry[:wwpn].to_s.upcase
          else
            port.wwpn = entry[:wwpn].upcase
          end
          unless entry[:port_alias].nil?
            port.port_alias = entry[:port_alias]
          else
            port.port_alias = 'None'
          end
          port.domain = entry[:domain]
          port.port = entry[:port]

          aix_port=AixPort.find_by_wwpn(port.wwpn)
          unless aix_port.nil?
            port.aix_port_id=aix_port.id
          end
          begin
            port.save!
          rescue Exception => e
            puts "ERROR: unable to save switch port  : #{e.message}"
            puts port.inspect
          end
        end
      end
    end
  end
  
  desc "fw_csv", "upload firmware recommended version from csv file"
  def fw_csv(filename)
      total_chunks = SmarterCSV.process(filename, :chunk_size => 500, :col_sep => ",") do |chunk|
      SwitchPort.transaction do
        chunk.each do |entry|
          fw = Firmware.new
          fw.model=entry[:model]
          fw.recommended = entry[:recommended_version]
          begin
            fw.save!
          rescue Exception => e
            puts "ERROR: unable to save firmware : #{e.message}"
            puts fw.inspect
          end 
        end
      end
    end        
  end 

  desc "aix_csv", "upload aix servers from csv file"
  def aix_csv(filename, version)
    total_chunks = SmarterCSV.process(filename, :chunk_size => 500, :col_sep => ";", :key_mapping => { :scm_manager=> nil, :scm_alias => nil }) do |chunk|
      Server.transaction do
        chunk.each do |entry|
                  
        next unless entry[:version] == version.to_f
          new_server = Server.new
          new_server.customer = entry[:customer]
          new_server.hostname = entry[:hostname]
          new_server.os_type = entry[:os_type]
          new_server.os_version = entry[:os_version]
          new_server.sys_fwversion = entry[:sys_fwversion]
          new_server.sys_serial = entry[:sys_id]
          new_server.sys_model = entry[:sys_model]
          new_server.global_image = entry[:global_image]
          new_server.install_date = entry[:aix_install_date]
          new_server.nim = entry[:nim]
          new_server.run_date = entry[:run_date]

          unless entry[:lparstat].nil?
            next unless entry[:lparstat] =~ /CPU/ 
            if entry[:lparstat] =~ /:/ 
              lparhash = Hash.new
              entry[:lparstat].split("|").each do |lpar_entry|
                lpar_info, lpar_value = lpar_entry.split(':')
               # lparhash[lpar_info.gsub(/CPU/, 'Cpu').gsub( /[A-Z]/){ ' ' + $& }.parameterize.underscore] =  lpar_value
                unless lpar_value.nil?  or lpar_value.empty? 
                  lparhash[lparstat_to_sym(lpar_info)] =  lpar_value
                else
                  lparhash[lparstat_to_sym(lpar_info)] = nil
                end
              end  
              new_server.build_lparstat
              new_server.lparstat.active_cpus_in_pool = lparhash[:active_cpus_in_pool] 
              new_server.lparstat.active_physical_cpus_in_system = lparhash[:active_physical_cpus_in_system] 
              new_server.lparstat.capacity_increment = lparhash[:capacity_increment] 
              new_server.lparstat.desired_capacity = lparhash[:desired_capacity] 
              new_server.lparstat.desired_memory = lparhash[:desired_memory] 
              new_server.lparstat.desired_variable_capacity_weight = lparhash[:desired_variable_capacity_weight] 
              new_server.lparstat.desired_virtual_cpus = lparhash[:desired_virtual_cpus] 
              new_server.lparstat.entitled_capacity = lparhash[:entitled_capacity] 
              new_server.lparstat.entitled_capacity_of_pool = lparhash[:entitled_capacity_of_pool] 
              new_server.lparstat.hypervisor_page_size = lparhash[:hypervisor_page_size] 
              new_server.lparstat.maximum_capacity = lparhash[:maximum_capacity] 
              new_server.lparstat.maximum_capacity_of_pool = lparhash[:maximum_capacity_of_pool] 
              new_server.lparstat.maximum_memory = lparhash[:maximum_memory] 
              new_server.lparstat.maximum_physical_cpus_in_system = lparhash[:maximum_physical_cpus_in_system] 
              new_server.lparstat.maximum_virtual_cpus = lparhash[:maximum_virtual_cpus] 
              new_server.lparstat.memory_group_id_of_lpar = lparhash[:memory_group_id_of_lpar] 
              new_server.lparstat.memory_mode = lparhash[:memory_mode] 
              new_server.lparstat.memory_pool = lparhash[:memory_pool] 
              new_server.lparstat.minimum_capacity = lparhash[:minimum_capacity] 
              new_server.lparstat.minimum_memory = lparhash[:minimum_memory] 
              new_server.lparstat.minimum_virtual_cpus = lparhash[:minimum_virtual_cpus] 
              new_server.lparstat.mode = lparhash[:mode] 
              new_server.lparstat.node_name = lparhash[:node_name] 
              new_server.lparstat.online_memory = lparhash[:online_memory] 
              new_server.lparstat.online_virtual_cpus = lparhash[:online_virtual_cpus] 
              new_server.lparstat.partition_group = lparhash[:partition_group] 
              new_server.lparstat.partition_name = lparhash[:partition_name] 
              new_server.lparstat.partition_number = lparhash[:partition_number] 
              new_server.lparstat.physical_cpu_percentage = lparhash[:physical_cpu_percentage] 
              new_server.lparstat.physical_memory_in_the_pool = lparhash[:physical_memory_in_the_pool] 
              new_server.lparstat.power_saving_mode = lparhash[:power_saving_mode] 
              new_server.lparstat.shared_physical_cpus_in_system = lparhash[:shared_physical_cpus_in_system] 
              new_server.lparstat.shared_pool = lparhash[:shared_pool] 
              new_server.lparstat.target_memory_expansion_factor = lparhash[:target_memory_expansion_factor] 
              new_server.lparstat.target_memory_expansion_size = lparhash[:target_memory_expansion_size] 
              new_server.lparstat.total_io_memory_entitlement = lparhash[:total_io_memory_entitlement] 
              new_server.lparstat.lpar_type = lparhash[:type] 
              new_server.lparstat.unallocated_capacity = lparhash[:unallocated_capacity] 
              new_server.lparstat.unallocated_io_memory_entitlement = lparhash[:unallocated_io_memory_entitlement] 
              new_server.lparstat.unallocated_variable_memory_capacity_weight = lparhash[:unallocated_variable_memory_capacity_weight] 
              new_server.lparstat.unallocated_weight = lparhash[:unallocated_weight] 
              new_server.lparstat.variable_capacity_weight = lparhash[:variable_capacity_weight] 
              new_server.lparstat.variable_memory_capacity_weight = lparhash[:variable_memory_capacity_weight]
            end
          end   
          
          unless entry[:wwpn].nil? 
            entry[:wwpn].gsub(/.*found. /, '')
            entry[:wwpn].split("|").each do |aix_port|
              fc_card = aix_port.split(":")
              unless fc_card[1].nil?
                if fc_card[1] =~ /^\h+$/
                  new_server.aix_ports.build( :port =>fc_card[0], :wwpn => fc_card[1])
                end
              end
            end
          end
          
          unless entry[:pcmpath].nil?
            unless entry[:pcmpath] == 'N/A'
              entry[:pcmpath].split(" ").each do |aix_path|
                path=aix_path.split("|")
                path.shift #first field empty in initial file
                unless path[2].nil?
                  new_server.aix_paths.build( :path => path[0], :adapter => path[1], :state => path[2], :mode => path[3])
                end
              end
            end
          end
          unless entry[:cpm].nil?
            new_server.healthchecks.build( :check => "cpm", :status => entry[:cpm] )
          end
           
          unless entry[:ssh].nil?
            new_server.healthchecks.build( :check => "ssh", :status => entry[:ssh] )
          end
          
          unless entry[:ntpd].nil?
            new_server.healthchecks.build( :check => "ntpd", :status => entry[:ntpd] )
          end          
          
          unless entry[:fibre_parameters].nil?
            new_server.healthchecks.build( :check => "fibre parameters", :status => entry[:fibre_parameters] )
          end
           
          unless entry[:syslog].nil?
            new_server.healthchecks.build( :check => "syslog", :status => entry[:syslog] )
          end  
                    
          begin 
            new_server.save!
          rescue  Exception => e
            puts "ERROR: unable to save server : #{e.message}"
            puts new_server.inspect
          end
          unless entry[:openssl].nil? 
            if entry[:openssl] =~ /openssl/i
              software=Software.find_or_create_by_name_and_version( :name => 'openssl', :version => entry[:openssl])
              deployment=SoftwareDeployment.create!( :server_id => new_server.id, :software_id => software.id )
            end
          end
          unless entry[:ssh_version].nil? 
            if entry[:ssh_version] =~ /openssh/i
              software=Software.find_or_create_by_name_and_version( :name => 'openssh', :version => entry[:ssh_version])
              deployment=SoftwareDeployment.create!( :server_id => new_server.id, :software_id => software.id )
            end
          end
          unless entry[:sudo_version].nil? 
            if entry[:sudo_version] =~ /sudo/i
              software=Software.find_or_create_by_name_and_version( :name => 'sudo', :version => entry[:sudo_version])
              deployment=SoftwareDeployment.create!( :server_id => new_server.id, :software_id => software.id )
            end
          end          
          unless entry[:sdd_driver].nil? 
            unless entry[:sdd_driver] == "NF"
              software=Software.find_or_create_by_name_and_version( :name => 'sdd driver', :version => entry[:sdd_driver])
              deployment=SoftwareDeployment.create!( :server_id => new_server.id, :software_id => software.id )
            end
          end   
        end
      puts "500 entries processed"   
      end
    end
  end
  
  no_tasks do
    def lparstat_to_sym(stat)
      convert_name = {
        "ActiveCPUsinPool"=> "active_cpus_in_pool",
        "ActivePhysicalCPUsinsystem" =>"active_physical_cpus_in_system",
        "CapacityIncrement" =>"capacity_increment",
        "DesiredCapacity" =>"desired_capacity",
        "DesiredMemory" =>"desired_memory",
        "DesiredVariableCapacityWeight" =>"desired_variable_capacity_weight",
        "DesiredVirtualCPUs" =>"desired_virtual_cpus",
        "EntitledCapacity" =>"entitled_capacity",
        "EntitledCapacityofPool" =>"entitled_capacity_of_pool",
        "HypervisorPageSize" =>"hypervisor_page_size",
        "MaximumCapacity" =>"maximum_capacity",
        "MaximumCapacityofPool" =>"maximum_capacity_of_pool",
        "MaximumMemory" =>"maximum_memory",
        "MaximumPhysicalCPUsinsystem" =>"maximum_physical_cpus_in_system",
        "MaximumVirtualCPUs" =>"maximum_virtual_cpus",
        "MemoryGroupIDofLPAR" =>"memory_group_id_of_lpar",
        "MemoryMode" =>"memory_mode",
        "MemoryPoolID" =>"memory_pool",
        "MinimumCapacity" =>"minimum_capacity",
        "MinimumMemory" =>"minimum_memory",
        "MinimumVirtualCPUs" =>"minimum_virtual_cpus",
        "Mode" =>"mode",
        "NodeName" =>"node_name",
        "OnlineMemory" =>"online_memory",
        "OnlineVirtualCPUs" =>"online_virtual_cpus",
        "PartitionGroup-ID" =>"partition_group",
        "PartitionName" =>"partition_name",
        "PartitionNumber" =>"partition_number",
        "PhysicalCPUPercentage" =>"physical_cpu_percentage",
        "PhysicalMemoryinthePool" =>"physical_memory_in_the_pool",
        "PowerSavingMode" =>"power_saving_mode",
        "SharedPhysicalCPUsinsystem" =>"shared_physical_cpus_in_system",
        "SharedPoolID" =>"shared_pool",
        "TargetMemoryExpansionFactor" =>"target_memory_expansion_factor",
        "TargetMemoryExpansionSize" =>"target_memory_expansion_size",
        "TotalI/OMemoryEntitlement" =>"total_io_memory_entitlement",
        "Type" =>"type",
        "UnallocatedCapacity" =>"unallocated_capacity",
        "UnallocatedI/OMemoryentitlement" =>"unallocated_io_memory_entitlement",
        "UnallocatedVariableMemoryCapacityWeight" =>"unallocated_variable_memory_capacity_weight",
        "UnallocatedWeight" =>"unallocated_weight",
        "VariableCapacityWeight" =>"variable_capacity_weight",
        "VariableMemoryCapacityWeight" =>"variable_memory_capacity_weight"}
        unless convert_name[stat].nil?
          convert_name[stat].to_sym
        else
          stat
        end
    end
  end
end



