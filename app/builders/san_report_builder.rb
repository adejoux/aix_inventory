class SanReportBuilder < ReportBuilder

  def build_query
    Wwpn.includes(:san_infra)
        .includes(:linux_port)
        .includes(:aix_port)
        .includes(:server => :server_attributes)
  end

  def datatable_data(page, per_page)
    server_list=search_result.page(page).per_page(per_page)
    build_rows(server_list)
  end

  def total_records
    Wwpn.count
  end

  def xlsx_data
    wwpn_list=search_result
    build_rows(server_list)
  end

  def first_header
    "wwpn"
  end

  def build_rows(wwpn_list)
    #build result array
    results=Hash.new{|hash, key| hash[key] = Hash.new}
    report.report_fields.each do |field|
      case field.association_type
        when "server_attribute"
          ServerAttribute.where(name: field.select_attribute).joins(:server).find_all_by_server_id(server_list.map { |srv| srv.id }).map { |res| results[res.server.hostname][res.name]=res.output }
        when "server"
          Server.find(server_list.map { |srv| srv.id}).map { |res| results[res.hostname][field.select_attribute]=res.send(field.select_attribute).to_s}
        when "hardware"
          Server.joins(:hardware).find(server_list.map { |srv| srv.id}).map { |res| results[res.hostname][field.select_attribute]=res.hardware.send(field.select_attribute)}
        when "lparstat"
          Server.includes(:lparstat).find(server_list.map { |srv| srv.id}).map do |res|
            begin
              res_value=res.lparstat.send(field.select_attribute)
            rescue
              res_value="N/F"
            end
            results[res.hostname][field.select_attribute]=res_value
          end
      end
    end

    servers=results.keys

    server_list.map do |server|
      row=[]
      row << server.hostname
      columns.each do |column|
        entry = results[server.hostname][column] || ""
        row << entry
      end
      row
    end
  end





  def columns
    @report.report_fields.select("select_attribute").map { |rq| rq.select_attribute }
  end

  def datatable_data
    server_list=@search.result.page(page).per_page(per_page)
    @search.build_condition
    build_rows(server_list)
  end

  def total_records
    Server.customer_scope(current_user.customer_scope).count
  end

  def xlsx_data
    server_list=@search.result
    @first_header="server"
    @search.build_condition
    build_rows(server_list)
  end

  def build_rows(server_list)
    #build result array
    results=Hash.new{|hash, key| hash[key] = Hash.new}
    report_fields.each do |field|
      case field.association_type
        when "server_attribute"
          ServerAttribute.where(name: field.select_attribute).joins(:server).find_all_by_server_id(server_list.map { |srv| srv.id }).map { |res| results[res.server.hostname][res.name]=res.output }
        when "server"
          Server.find(server_list.map { |srv| srv.id}).map { |res| results[res.hostname][field.select_attribute]=res.send(field.select_attribute).to_s}
        when "hardware"
          Server.joins(:hardware).find(server_list.map { |srv| srv.id}).map { |res| results[res.hostname][field.select_attribute]=res.hardware.send(field.select_attribute)}
        when "lparstat"
          Server.includes(:lparstat).find(server_list.map { |srv| srv.id}).map do |res|
            begin
              res_value=res.lparstat.send(field.select_attribute)
            rescue
              res_value="N/F"
            end
            results[res.hostname][field.select_attribute]=res_value
          end
      end
    end

    servers=results.keys

    server_list.map do |server|
      row=[]
      row << server.hostname
      @columns.each do |column|
        entry = results[server.hostname][column] || ""
        row << entry
      end
      row
    end
  end
end
