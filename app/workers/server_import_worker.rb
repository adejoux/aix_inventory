class ServerImportWorker
  include Sidekiq::Worker

  def process_server(filename)
    doc = Nokogiri.XML(File.open(filename,"rb"))
    data = Hash.from_xml(doc.to_xml)

    if data["servers"].nil?
      puts "error: file not valid"
      exit 1
    end

    if data["servers"]["server"].nil?
      puts "error: file not valid"
      exit 1
    end

    data["servers"]["server"].each do |srv|
      server=Server.find_or_create_by_hostname(:hostname => srv["name"])
      server.run_date=srv["run"]
      server.os_version=srv["os_version"].values.join(" ")
      server.os_type=srv["os_type"]



  end


  def perform
    puts Rails.root
    new_path=Rails.root.join('import','server','new').to_s
    done_path=Rails.root.join('import','server','imported').to_s
    files = Dir.entries(new_path).select{|x| x.end_with?("json")}
    files.each do |x|
      process_server([new_path,x].join('/'))
      File.rename([new_path,x].join('/'), [done_path,x+Time.new.to_s.gsub(' ','-')].join('/'))
    end
  end

end
