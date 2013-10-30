class ServerReportBuilder < ReportBuilder

  def build_query
    Server.joins(:operating_system_type)
          .where(operating_system_types: { id: @report.operating_system_type_ids } )
          .where(customers: {id: @report.customer_ids} )
          .includes(:operating_system)
          .joins(:customer)
  end

  def datatable_data(page, per_page)
    @server_list=search_result.page(page).per_page(per_page).select("servers.id").map { |server| server.id }
    build_rows
  end

  def total_records
    Server.count
  end

  def xlsx_data
    @server_list=search_result.select("servers.id").map { |server| server.id }
    build_rows
  end

  def first_header
    "server"
  end

  def server_attribute_request(field)
    Server.joins(:server_attributes)
          .where(server_attributes: {name: field.select_attribute })
          .select("hostname, server_attributes.output AS output")
          .find_all_by_id(@server_list)
          .map do |server|
            begin
              result=server.output.to_s
            rescue
              result=""
            end
            @results[server.hostname][field.select_attribute]=result
          end
  end

  def server_request(field)
    Server.find_all_by_id(@server_list)
          .map do |server|
            begin
              result=server.send(field.select_attribute).to_s
            rescue
              result=""
            end
            @results[server.hostname][field.select_attribute]=result
          end
  end

  def hardware_request(field)
    Server.joins(:hardware)
          .find_all_by_id(@server_list)
          .map do |server|
            begin
              result=server.hardware.send(field.select_attribute).to_s
            rescue
              result=""
            end
            @results[server.hostname][field.select_attribute]=result
          end
  end

  def lparstat_request(field)
    Server.joins(:lparstat)
          .find_all_by_id(@server_list)
          .map do |server|
            begin
              result=server.lparstat.send(field.select_attribute).to_s
            rescue
              result=""
            end
            @results[server.hostname][field.select_attribute]=result
          end
  end

  def build_rows
    #build result array
    report.report_fields.each do |field|
      send("#{field.association_type}_request",field)
    end

    Server.select(:hostname).find(@server_list).map do |server|
      row=[]
      row << server.hostname
      columns.each do |column|
        entry = @results[server.hostname][column] || ""
        row << entry
      end
      row
    end
  end
end
