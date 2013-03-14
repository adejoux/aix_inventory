class Upload < ActiveRecord::Base
  include Workflow
  attr_accessible :upload, :import_type, :workflow_state
  has_attached_file :upload
  has_many :import_logs
  
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
    
    import_log = self.import_logs.create

    import_log.content = "starting importing #{self.upload_file_name}\n"
    unless self.csv_file_content?
      import_log.content << "ERROR: not a csv file\n"
      import_log.result = failed
      import_log.save
      upload.failed!
      return false
    end

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
            import_log.content << "ERROR: unable to save server : #{e.message}\n"
            import_log.content << server.inspect
          end
        end
      end
    end
    import_log.save
  end
  #handle_asynchronously :server_import

  def san_import

  end
  handle_asynchronously :san_import

  def sod_import

  end
  handle_asynchronously :sod_import  

  def csv_file_content?
    if upload_content_type.match(/csv/)
      return true
    else
      return false
    end
  end

end
