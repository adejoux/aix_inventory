class XmlServerImportWorker

  def process_server(filename)
    log=ImportReport.new
    log.filename=filename
    log.output=""
    log.success_count=0
    log.error_count=0

    doc = Nokogiri.XML(File.open(filename,"rb"))
    data = Hash.from_xml(doc.to_xml)

    if data["servers"].nil?
      log.file_error!("KO", "error: file not valid")
      return
    end

    if data["servers"]["server"].nil?
      log.file_error!("KO", "error: file not valid")
      return
    end

    servers=[]
    servers=data["servers"]["server"] if data["servers"]["server"].is_a?(Array)
    servers << data["servers"]["server"] if data["servers"]["server"].is_a?(Hash)
    servers.each do |srv|
      next if srv["os_type"].nil? or srv["os_version"].nil?
      ActiveRecord::Base.transaction do
        puts "server:  #{srv["name"]}"
        tscm_customer=File.basename(filename).sub(/-\d+.xml/, '')

        customer=CUSTOMER_RENAMING[tscm_customer] || tscm_customer

        hostname=srv["name"].downcase.sub(/\..*/, '')
        server=Server.find_or_initialize_by_hostname(hostname: hostname)
        os_type=srv["os_type"]
        server.operating_system_type=OperatingSystemType.where(name: os_type).first
        if server.operating_system_type.nil?
          server.operating_system_type=OperatingSystemType.create(name: os_type)
        end
        srv.except!("os_type")

        os_version=srv["os_version"]
        server.operating_system=OperatingSystem.where(release: os_version).first
        if server.operating_system.nil?
          server.operating_system=OperatingSystem.create( release: os_version)
        end
        srv.except!("os_version")

        server.customer=Customer.where(name: customer).first || Customer.create(name: customer)
        begin
         server.save!
        rescue Exception => e
          log.output << "SAVE ERROR: #{e.message}\n"
          log.error_count += 1
        end
        server.add_or_update_attribute("tscm_customer", tscm_customer)

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
              server.add_or_update_attribute(attr, srv[attr])
            end
          srv.except!(attr)
          end
        end

        srv.except!("lspath")
        srv.except!("powerpath")
        srv.except!("pcmpath")
        srv.except!("adapters")
        unless srv["lssecfixes"].nil?
          ['overdue', 'list'].each do |category|
            begin
              srv["lssecfixes"][category]["package"].each do |package|
                server.add_or_update_secfix(package["name"], package["rhsa"], category, package["severity"])
              end
            rescue
            end
          end
          srv.except!("lssecfixes")
        end

        unless srv["lsvg"].nil?
          vgs=[]
          vgs[0]=srv["lsvg"]["vg"] if srv["lsvg"]["vg"].is_a?(Hash)
          vgs=srv["lsvg"]["vg"] if srv["lsvg"]["vg"].is_a?(Array)
          vgs.each do |vg|
            server.add_or_update_vg(vg["name"], vg["size"], vg["free"])
          end
          srv.except!("lsvg")
        end

        unless srv["lsdf"].nil?
          begin
            srv["lsdf"]["fs"].each do |fs|
              server.add_or_update_fs(fs["name"], fs["device"], fs["size"], fs["free"])
            end
          rescue
          end
          srv.except!("lsdf")
        end

        unless srv["wwpn"].nil?
          wwpns=[]
          wwpns[0]=srv["wwpn"]["port"] if srv["wwpn"]["port"].is_a?(Hash)
          wwpns=srv["wwpn"]["port"] if srv["wwpn"]["port"].is_a?(Array)
            wwpns.each do |port|
              if port["name"].match(/host/)
                server.add_or_update_linux_port(port["name"], port["brand"], port["model"], port["type"], port["speed"], port["slot"], port["driver"], port["wwn"], port["fwversion"])
              end
              if port["name"].match(/fc/)
                server.add_or_update_aix_port(port["name"], port["wwn"])
              end
            end
          srv.except!("wwpn")
        end

        unless srv["lparstat"].nil? or  srv["lparstat"]["stat"].nil?
          lparstat = server.lparstat || server.build_lparstat
          begin
            srv["lparstat"]["stat"].each do |stat|
                attribute=lparstat_to_sym(stat["name"])
                lparstat.send("#{attribute}=", stat["value"])
            end
          rescue
          end
          srv.except!("lparstat")
        end

        srv.each_key do |attr|
          next if srv[attr].nil?
          begin
            srv[attr].each_key do |sub_attr|
              server.add_or_update_attribute("#{attr}_#{sub_attr}", srv[attr][sub_attr])
            end
          rescue Exception => e
            puts "error: unable to import #{attr} #{e.message}"
          end
          srv.except!(attr)
        end

        begin
          server.save!
          server.activities.find_or_create_by_action("update").touch
          log.success_count += 1

        rescue Exception => e
          log.output << "SAVE ERROR: #{e.message}\n"
          log.error_count += 1
        end
      end
    end
    log.analyze_result
    log.save!
    puts "#{log.filename} success : #{log.success_count} error: #{log.error_count}"
    Rails.cache.clear
  end

  def perform
    ActiveRecord::Base.logger.level = 1
    new_path=Rails.root.join('import', 'cleaned', 'server').to_s
    done_path=Rails.root.join('import', 'imported', 'server').to_s
    files = Dir.entries(new_path).select{|x| x.end_with?("xml")}
    files.each do |file|
      puts "processing file #{file}\n"
      begin
        process_server([new_path,file].join('/'))
      rescue
        puts "error in handling  #{file}\n"
      end
      File.unlink([new_path,file].join('/'))
    end
  end

  private
  def lparstat_to_sym(stat)
    FIELD_RENAMING[stat] || stat
  end

end
