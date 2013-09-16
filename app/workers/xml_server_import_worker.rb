class XmlServerImportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

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
      server=Server.find_or_create_by_hostname(:hostname => srv["name"].downcase)

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

      unless srv["lssecfixes"].nil?
        ['overdue', 'list'].each do |category|
          srv["lssecfixes"][category]["package"].each do |package|
            server.add_or_update_secfix(package["name"], package["rhsa"], category, package["severity"])
          end
        end
      end

      unless srv["lsvg"].nil?
        vgs=[]
        vgs[0]=srv["lsvg"]["vg"] if srv["lsvg"]["vg"].is_a?(Hash)
        vgs=srv["lsvg"]["vg"] if srv["lsvg"]["vg"].is_a?(Array)
        vgs.each do |vg|
          server.add_or_update_vg(vg["name"], vg["size"], vg["free"])
        end
      end

      unless srv["lsdf"].nil?
        srv["lsdf"]["fs"].each do |fs|
          server.add_or_update_fs(fs["name"], fs["size"], fs["free"])
        end
      end

      unless srv["wwpn"].nil?
        srv["wwpn"]["port"].each do |port|
          unless port["brand"].nil?
            server.add_or_update_linux_port(port["name"], port["brand"], port["card_model"], port["card_type"], port["speed"], port["slot"], port["driver"], port["wwn"])
          end
        end
      end

      srv.each_key do |attr|
        if srv[attr].is_a?(String)
          begin
            server.send("#{attr}=", srv[attr])
          rescue
            server.add_or_update_attribute(attr, srv[attr])
          end
        end
      end
      begin
        server.save!
      rescue Exception => e
        puts "SAVE ERROR: #{e.message}\n"
        puts server.to_yaml
        #puts server.server_attributes.to_yaml
        puts server.hardware.to_yaml
      end
    end

    Rails.cache.clear
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
