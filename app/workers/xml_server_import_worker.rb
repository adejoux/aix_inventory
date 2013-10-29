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
      ActiveRecord::Base.transaction do

        tscm_customer=File.basename(filename).sub(/.xml/, '')

        customer=CUSTOMER_RENAMING[tscm_customer] || tscm_customer

        server=Server.find_or_create_by_hostname(hostname: srv["name"].downcase)
        server.customer=Customer.where(name: customer).first || Customer.create(name: customer)
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

        unless srv["os_type"].nil?
          os_type=srv["os_type"]
          server.operating_system_type=OperatingSystemType.where(name: os_type).first || OperatingSystemType.create(name: os_type)
          srv.except!("os_type")
        end

        unless srv["os_version"].nil?
          os_version=srv["os_version"]
          server.operating_system=OperatingSystem.where(release: os_version).first || OperatingSystem.create( release: os_version, operating_system_type_id: server.operating_system_type.id)
          srv.except!("os_version")
        end

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
          begin
            srv["wwpn"]["port"].each do |port|
              if port["name"].match(/host/)
                server.add_or_update_linux_port(port["name"], port["brand"], port["model"], port["type"], port["speed"], port["slot"], port["driver"], port["wwn"], port["fwversion"])
              end
              if port["name"].match(/fc/)
                server.add_or_update_aix_port(port["name"], port["wwn"])
              end
            end
          rescue
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
    puts "#{log.filename} success : #{log.success_count}"
    Rails.cache.clear
  end

  def perform
    ActiveRecord::Base.logger.level = 1
    new_path=Rails.root.join('import', 'new', 'server').to_s
    done_path=Rails.root.join('import', 'imported', 'server').to_s
    files = Dir.entries(new_path).select{|x| x.end_with?("xml")}
    files.each do |file|
      puts "processing file #{file}\n"
      process_server([new_path,file].join('/'))
      File.rename([new_path,file].join('/'), [done_path,file+Time.new.to_formatted_s(:number)].join('/'))
    end
  end

  private
  def lparstat_to_sym(stat)
    FIELD_RENAMING[stat] || stat
  end

end
