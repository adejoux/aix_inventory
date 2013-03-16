lass ServerImport
  # switch to ActiveModel::Model in Rails 4
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :csv_line

  def initialize(server_id, entry)
    @server_id
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

  def load_imported_server
    server = Server.find_by_customer_and_hostname(csv_line[:customer], csv_line[:hostname]) || Server.new
    server.customer = csv_line[:customer]
    server.hostname = csv_line[:hostname]
    server.os_type = csv_line[:os_type]
    server.os_version = csv_line[:os_version]
    server.sys_fwversion = csv_line[:sys_fwversion]
    server.sys_serial = csv_line[:sys_id].to_s
    server.sys_model = csv_line[:sys_model]
    server.global_image = csv_line[:global_image]
    server.install_date = csv_line[:aix_install_date]
    server.nim = csv_line[:nim]
    server.run_date = csv_line[:run_date]

    unless csv_line[:wwpn].nil? 
      csv_line[:wwpn].gsub(/.*found. /, '')
      csv_line[:wwpn].split("|").each do |aix_port|
        fc_card = aix_port.split(":")
        unless fc_card[1].nil?
          if fc_card[1] =~ /^\h+$/
            aix_port = AixPort.find_by_server_and_wwpn(server.id, fc_card[1].to_s.upcase)
            unless aix_port.nil? 
              aix_port.port=fc_card[0]
              aix_port.wwpn=fc_card[1].to_s.upcase
            else
              server.aix_ports.build(:port => fc_card[0], :wwpn => fc_card[1].to_s.upcase )  
            end 
          end
        end
      end
    end
          
        

          # unless csv_line[:openssl].nil? 
          #   if csv_line[:openssl] =~ /openssl/i
          #     software=Software.find_or_create_by_name_and_version( :name => 'openssl', :version => csv_line[:openssl])
          #     deployment=SoftwareDeployment.create!( :server_id => new_server.id, :software_id => software.id )
          #   end
          # end
          # unless csv_line[:ssh_version].nil? 
          #   if csv_line[:ssh_version] =~ /openssh/i
          #     software=Software.find_or_create_by_name_and_version( :name => 'openssh', :version => csv_line[:ssh_version])
          #     deployment=SoftwareDeployment.create!( :server_id => new_server.id, :software_id => software.id )
          #   end
          # end
          # unless csv_line[:sudo_version].nil? 
          #   if csv_line[:sudo_version] =~ /sudo/i
          #     software=Software.find_or_create_by_name_and_version( :name => 'sudo', :version => csv_line[:sudo_version])
          #     deployment=SoftwareDeployment.create!( :server_id => new_server.id, :software_id => software.id )
          #   end
          # end          
          # unless csv_line[:sdd_driver].nil? 
          #   unless csv_line[:sdd_driver] == "NF"
          #     software=Software.find_or_create_by_name_and_version( :name => 'sdd driver', :version => csv_line[:sdd_driver])
          #     deployment=SoftwareDeployment.create!( :server_id => new_server.id, :software_id => software.id )
          #   end
          # end 
    server
  end