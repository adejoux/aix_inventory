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

      result=Hardware.find_by_serial(srv["sys_id"])
      if result.nil?
        server.build_hardware
        server.hardware.sys_model=srv["sys_model"]
        server.hardware.serial=srv["sys_id"]
        server.hardware.firmware=srv["firmware"]
      else
        server.hardware=result
      end

      srv.except!("firmware")
      srv.except!("sys_id")
      srv.except!("sys_model")

      srv.each_key do |attr|
        if srv[attr].is_a?(String)
          begin
            server.send("#{attr}=", srv[attr])
          rescue
            conf = server.server_attributes.select{|h| h.name== attr}.first
            if conf.nil?
              server.server_attributes.build(:name=>attr, :output=> srv[attr], :category => "inv")
            else
              conf.update_attributes( :output=> srv[attr])
            end
          end
        end
      end
      begin
        server.save!
        puts server.hardware.inspect
      rescue Exception => e
        puts "SAVE ERROR: #{e.message}\n"
        puts server.to_yaml
        #puts server.server_attributes.to_yaml
        puts server.hardware.to_yaml
      end
    end
  end


  def perform
    new_path=Rails.root.join('import', 'new', 'server').to_s
    done_path=Rails.root.join('import', 'imported', 'server').to_s
    files = Dir.entries(new_path).select{|x| x.end_with?("xml")}
    files.each do |x|
      process_server([new_path,x].join('/'))
      #File.rename([new_path,x].join('/'), [done_path,x+Time.new.to_formatted_s(:number)].join('/'))
    end
  end

end
