class CsvSanImportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def process_server(filename)
    log=ImportReport.new
    log.filename=filename
    log.output=""
    log.success_count=0
    log.error_count=0

    total_chunks = SmarterCSV.process(filename, :chunk_size => 500, :col_sep => ":") do |chunk|
      ActiveRecord::Base.transaction do
        chunk.each do |csv_line|
          next if csv_line[:wwpn].nil?
          next if csv_line[:wwpn].to_s.empty?

          san_infra=SanInfra.find_by_switch_and_port(csv_line[:switch], csv_line[:port]) || SanInfra.new
          san_infra.infra = csv_line[:infra]
          san_infra.fabric = csv_line[:fabric]
          san_infra.switch = csv_line[:switch]
          san_infra.port = csv_line[:port]
          san_infra.speed = csv_line[:speed]
          san_infra.status = csv_line[:status]
          san_infra.portname = csv_line[:portname]
          san_infra.mode = csv_line[:mode]

          begin
            san_infra.save!
            san_infra.activities.find_or_create_by_action("update").touch
            log.success_count += 1
          rescue Exception => e
            log.output << "SAVE ERROR: #{e.message}\n"
            puts "#{e.message}\n"
            puts san_infra.inspect
            log.error_count += 1
          end

          csv_line[:wwpn].to_s.split(',').each do |wwpn_id|
            wwpn_id=wwpn_id.to_s.upcase.gsub(':', '')
            wwpn = Wwpn.find_by_wwpn(wwpn_id)
            if wwpn.nil?
              san_infra.wwpns.create!( :wwpn => wwpn_id )
            else
              wwpn.san_infra_id=san_infra.id
              wwpn.save!
            end
          end
        end
      end
    end
    log.analyze_result
    log.save!
    puts "#{log.filename} success : #{log.success_count}"
    Rails.cache.clear
  end

  def perform
    new_path=Rails.root.join('import', 'new', 'san').to_s
    done_path=Rails.root.join('import', 'imported', 'san').to_s
    files = Dir.entries(new_path).select{|x| x.end_with?("csv")}
    files.each do |file|
      puts "processing file #{file}\n"
      process_server([new_path,file].join('/'))
      File.rename([new_path,file].join('/'), [done_path,file+Time.new.to_formatted_s(:number)].join('/'))
    end
  end
end
