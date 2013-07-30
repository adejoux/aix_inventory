# == Schema Information
#
# Table name: uploads
#
#  id                  :integer          not null, primary key
#  upload_file_name    :string(255)
#  upload_content_type :string(255)
#  upload_file_size    :integer
#  upload_updated_at   :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  import_type         :string(255)
#  workflow_state      :string(255)
#

class Upload < ActiveRecord::Base
  include Workflow
  attr_accessible :upload, :import_type, :workflow_state
  has_attached_file :upload
  has_one :import_log, :dependent => :destroy

  TYPES = %w[server san sod]

  workflow do
    state :new do
      event :uploading, :transition_to => :uploaded
    end
    state :uploaded do
      event :processing, :transition_to => :importing
    end

    state :importing do
      event :processed, :transition_to => :imported
    end

    state :imported do
      event :success, :transition_to => :processed
      event :partial, :transition_to => :partially
      event :error, :transition_to => :failed
    end

    state :processed
    state :partially
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
    processed!
    Rails.cache.clear
  end
  handle_asynchronously :processing

  def server_import
    import_log = self.build_import_log
    import_log.success_count=0
    import_log.error_count=0
    import_log.save
    import_log.content = "starting importing #{self.upload_file_name}\n"
    unless self.csv_file_content?
      import_log.content << "ERROR: not a csv file\n"
      import_log.save
      return false
    end

    total_chunks = SmarterCSV.process(self.upload.path, :chunk_size => 500, :col_sep => ";", :key_mapping => { :scm_manager=> nil, :scm_alias => nil }) do |chunk|
      Server.transaction do
        chunk.each do |entry|
          if entry[:run_date].nil?
            import_log.content << "PROCESSING ERROR: unable to save this entry : \n #{entry}"
            import_log.error_count += 1
            next
          end
          next unless entry[:version] == "1.8".to_f
          imported_server = ServerImport.new(entry)
          begin
            imported_server.save!
            imported_server.save_softwares!
          rescue  Exception => e
            import_log.error_count += 1
            import_log.content << "SAVE ERROR: #{e.message}\n"
            import_log.content << imported_server.to_yaml
          else
            import_log.success_count += 1
          end
        end
      end
    end
    import_log.save
  end

  def san_import
    import_log = self.build_import_log
    import_log.success_count=0
    import_log.error_count=0
    import_log.save
    import_log.content = "starting importing #{self.upload_file_name}\n"
    unless self.csv_file_content?
      import_log.content << "ERROR: not a csv file\n"
      import_log.save
      return false
    end

    total_chunks = SmarterCSV.process(self.upload.path, :chunk_size => 500, :col_sep => ":", :key_mapping => { :scm_manager=> nil, :scm_alias => nil }) do |chunk|
      SanInfra.transaction do
        chunk.each do |entry|
          if entry[:mode].nil?
            import_log.error_count += 1
            next
          end
          imported_san_infra = SanInfraImport.new(entry)
          begin
            imported_san_infra.save!
            imported_san_infra.save_wwpns!
          rescue  Exception => e
            import_log.error_count += 1
            import_log.content << "SAVE ERROR: #{e.message}\n"
            import_log.content << imported_san_infra.to_yaml
          else
            import_log.success_count += 1
          end
        end
      end
    end
    import_log.save
  end


  def sod_import

  end


  def csv_file_content?
    if upload_content_type.match(/csv/)
      return true
    else
      return false
    end
  end

  def self.imported_state
    where(:workflow_state => "imported")
  end

  def analyze_result
    if import_log.success_count == 0
      error!
    elsif import_log.error_count > 0
      partial!
    else
      success!
    end
  end
end
