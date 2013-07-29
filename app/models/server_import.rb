class ServerImport
  # switch to ActiveModel::Model in Rails 4
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :csv_line

  def initialize(entry)
    @csv_line=entry
  end

  def persisted?
    false
  end

  def csv_line
    @csv_line
  end

  def save
    imported_server.save
  end

  def save!
    imported_server.save!
  end

  def imported_server
    @imported_server ||= load_imported_server
  end

  def server
    @server ||= get_server
  end

  def get_server
    Server.find_by_customer_and_hostname(csv_line[:customer], csv_line[:hostname]) || Server.new
  end

  def load_imported_server
    server.customer = csv_line[:customer]
    server.hostname = csv_line[:hostname]
    server.os_type = csv_line[:os_type]

    server.os_version = csv_line[:os_version]
    hardware=server.build_hardware
    hardware.firmware = csv_line[:sys_fwversion]
    hardware.serial = csv_line[:sys_id].to_s
    hardware.sys_model = csv_line[:sys_model]
    server.run_date = csv_line[:run_date]

    if csv_line[:lparstat] =~ /:/
      lparhash = Hash.new
      csv_line[:lparstat].split("|").each do |lpar_entry|
        lpar_info, lpar_value = lpar_entry.split(':')
        unless lpar_value.nil?  or lpar_value.empty?
          lparhash[lparstat_to_sym(lpar_info)] =  lpar_value
        else
          lparhash[lparstat_to_sym(lpar_info)] = nil
        end
      end

      lparstat = server.lparstat || server.build_lparstat
      lparstat.active_cpus_in_pool = lparhash[:active_cpus_in_pool]
      lparstat.active_physical_cpus_in_system = lparhash[:active_physical_cpus_in_system]
      lparstat.capacity_increment = lparhash[:capacity_increment]
      lparstat.desired_capacity = lparhash[:desired_capacity]
      lparstat.desired_memory = lparhash[:desired_memory]
      lparstat.desired_variable_capacity_weight = lparhash[:desired_variable_capacity_weight]
      lparstat.desired_virtual_cpus = lparhash[:desired_virtual_cpus]
      lparstat.entitled_capacity = lparhash[:entitled_capacity]
      lparstat.entitled_capacity_of_pool = lparhash[:entitled_capacity_of_pool]
      lparstat.hypervisor_page_size = lparhash[:hypervisor_page_size]
      lparstat.maximum_capacity = lparhash[:maximum_capacity]
      lparstat.maximum_capacity_of_pool = lparhash[:maximum_capacity_of_pool]
      lparstat.maximum_memory = lparhash[:maximum_memory]
      lparstat.maximum_physical_cpus_in_system = lparhash[:maximum_physical_cpus_in_system]
      lparstat.maximum_virtual_cpus = lparhash[:maximum_virtual_cpus]
      lparstat.memory_group_id_of_lpar = lparhash[:memory_group_id_of_lpar]
      lparstat.memory_mode = lparhash[:memory_mode]
      lparstat.memory_pool = lparhash[:memory_pool]
      lparstat.minimum_capacity = lparhash[:minimum_capacity]
      lparstat.minimum_memory = lparhash[:minimum_memory]
      lparstat.minimum_virtual_cpus = lparhash[:minimum_virtual_cpus]
      lparstat.mode = lparhash[:mode]
      lparstat.node_name = lparhash[:node_name]
      lparstat.online_memory = lparhash[:online_memory]
      lparstat.online_virtual_cpus = lparhash[:online_virtual_cpus]
      lparstat.partition_group = lparhash[:partition_group]
      lparstat.partition_name = lparhash[:partition_name]
      lparstat.partition_number = lparhash[:partition_number]
      lparstat.physical_cpu_percentage = lparhash[:physical_cpu_percentage]
      lparstat.physical_memory_in_the_pool = lparhash[:physical_memory_in_the_pool]
      lparstat.power_saving_mode = lparhash[:power_saving_mode]
      lparstat.shared_physical_cpus_in_system = lparhash[:shared_physical_cpus_in_system]
      lparstat.shared_pool = lparhash[:shared_pool]
      lparstat.target_memory_expansion_factor = lparhash[:target_memory_expansion_factor]
      lparstat.target_memory_expansion_size = lparhash[:target_memory_expansion_size]
      lparstat.total_io_memory_entitlement = lparhash[:total_io_memory_entitlement]
      lparstat.lpar_type = lparhash[:type]
      lparstat.unallocated_capacity = lparhash[:unallocated_capacity]
      lparstat.unallocated_io_memory_entitlement = lparhash[:unallocated_io_memory_entitlement]
      lparstat.unallocated_variable_memory_capacity_weight = lparhash[:unallocated_variable_memory_capacity_weight]
      lparstat.unallocated_weight = lparhash[:unallocated_weight]
      lparstat.variable_capacity_weight = lparhash[:variable_capacity_weight]
      lparstat.variable_memory_capacity_weight = lparhash[:variable_memory_capacity_weight]
    end

    unless csv_line[:wwpn].nil?
      csv_line[:wwpn].gsub(/.*found. /, '')
      csv_line[:wwpn].split("|").each do |aix_port|
        fc_card = aix_port.split(":")
        unless fc_card[1].nil?
          if fc_card[1] =~ /^\h+$/
            aix_port = AixPort.find_by_server_id_and_port(server.id, fc_card[0])
            unless aix_port.nil?
              aix_port.port=fc_card[0]
            else
              aix_port=server.aix_ports.build(:port => fc_card[0])
              wwpn = Wwpn.find_by_wwpn(fc_card[1].to_s.upcase)
              unless wwpn.nil?
                aix_port.wwpn = wwpn
              else
                aix_port.build_wwpn(:wwpn => fc_card[1].to_s.upcase)
              end
            end
          end
        end
      end
    end

    unless csv_line[:pcmpath].nil?
      unless csv_line[:pcmpath] == 'N/A'
        csv_line[:pcmpath].split(" ").each do |aix_path|
          path=aix_path.split("|")
          path.shift #first field empty in initial file
          unless path[2].nil?
            aix_path = AixPath.find_by_server_id_and_adapter(server.id, path[1])
            unless aix_path.nil?
              aix_path.path=path[0]
              aix_path.adapter=path[1]
              aix_path.state=path[2]
              aix_path.mode=path[3]
            else
              server.aix_paths.build( :path => path[0], :adapter => path[1], :state => path[2], :mode => path[3])
            end
          end
        end
      end
    end

    unless csv_line[:cpm].nil?
      update_or_build_healthcheck("cpm", csv_line[:cpm])
    end

    unless csv_line[:ssh].nil?
      update_or_build_healthcheck("ssh", csv_line[:ssh])
    end

    unless csv_line[:ntpd].nil?
      update_or_build_healthcheck("ntpd", csv_line[:ntpd])
    end

    unless csv_line[:fibre_parameters].nil?
      update_or_build_healthcheck( "fibre parameters", csv_line[:fibre_parameters])
    end

    unless csv_line[:syslog].nil?
      update_or_build_healthcheck( "syslog", csv_line[:syslog])
    end
    server
  end

   def save_softwares!
    unless csv_line[:openssl].nil?
      if csv_line[:openssl] =~ /openssl/i
        set_software_deployment('openssl', csv_line[:openssl])
      end
    end
    unless csv_line[:ssh_version].nil?
      if csv_line[:ssh_version] =~ /openssh/i
        set_software_deployment( 'openssh',  csv_line[:ssh_version])
      end
    end
    unless csv_line[:sudo_version].nil?
      if csv_line[:sudo_version] =~ /sudo/i
        set_software_deployment( 'sudo', csv_line[:sudo_version])
      end
    end
    unless csv_line[:sdd_driver].nil?
      unless csv_line[:sdd_driver] == "NF"
        set_software_deployment( 'sdd driver', csv_line[:sdd_driver])
      end
    end
  end

  def get_software(name, version)
    Software.find_by_name_and_version(name, version) || Software.create(:name => name, :version => version)
  end

  def set_software_deployment(name, version)
    software=get_software(name,version)
    SoftwareDeployment.find_by_server_id_and_software_id(server.id, software.id) || SoftwareDeployment.create!( :server_id => server.id, :software_id => software.id )
  end


private
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

  def update_or_build_healthcheck(check, status)
    hc = Healthcheck.find_by_server_id_and_check(server.id, check)
    if hc.nil?
      server.healthchecks.build( :check => check, :status => status )
    else
      hc.status=status
    end
  end
end
