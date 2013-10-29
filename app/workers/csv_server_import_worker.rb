class CsvServerImportWorker

  def process_ip(filename)
    servers=Server.select(:hostname).map { |s| s.hostname }
    total_chunks = SmarterCSV.process(filename, :chunk_size => 500) do |chunk|
      chunk.each do |entry|
        unless entry[:ip_address].nil?
          next unless servers.include?(entry[:hostname].downcase)
          server=Server.find_by_hostname(entry[:hostname].downcase)
          next if server.nil?
          server.add_or_update_ip_address(entry[:ip_address], entry[:subnet], entry[:mac_address])
          server.save!
        end
      end
    end

  end


  def perform
    new_path=Rails.root.join('import', 'new', 'server').to_s
    done_path=Rails.root.join('import', 'imported', 'server').to_s
    files = Dir.entries(new_path).select{|x| x.end_with?("csv")}
    files.each do |x|
      process_ip([new_path,x].join('/'))
      #File.rename([new_path,x].join('/'), [done_path,x+Time.new.to_formatted_s(:number)].join('/'))
    end
  end
end
