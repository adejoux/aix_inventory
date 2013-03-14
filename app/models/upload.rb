class Upload < ActiveRecord::Base
  include Workflow
  attr_accessible :upload, :import_type, :workflow_state
  has_attached_file :upload
  
  TYPES = %w[server san sod]

  workflow do
    state :new do
      event :uploading, :transition_to => :uploaded
    end
    state :uploaded do
      event :processing, :transition_to => :importing
    end

    state :importing do
      event :success, :transition_to => :processed
      event :error, :transition_to => :failed
    end

    state :processed
    state :failed
  end

  def processing
    case import_type
      when 'server'
        server_import
      when 'san'
        san_import
      when 'sod'
        sod_import
    end
  end
  
  def server_import
    total_chunks = SmarterCSV.process(self.upload.path, :chunk_size => 500, :col_sep => "\t", :key_mapping => { :scm_manager=> nil, :scm_alias => nil }) do |chunk|
      Server.transaction do
        chunk.each do |entry|
          next unless entry[:version] == "1.8".to_f
          server = Server.find_by_customer_and_hostname(entry[:customer], entry[:hostname]) || Server.new
          server.customer = entry[:customer]
          server.hostname = entry[:hostname]
          server.os_type = entry[:os_type]
          server.os_version = entry[:os_version]
          server.sys_fwversion = entry[:sys_fwversion]
          server.sys_serial = entry[:sys_id]
          server.sys_model = entry[:sys_model]
          server.global_image = entry[:global_image]
          server.install_date = entry[:aix_install_date]
          server.nim = entry[:nim]
          server.run_date = entry[:run_date]
          begin 
            server.save!
          rescue  Exception => e
            puts "ERROR: unable to save server : #{e.message}"
            puts server.inspect
          end
        end
      end
    end
  end
  handle_asynchronously :server_import

  def san_import

  end
  handle_asynchronously :san_import

  def sod_import

  end
  handle_asynchronously :sod_import  
end
