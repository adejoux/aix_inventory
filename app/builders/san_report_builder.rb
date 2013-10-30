class SanReportBuilder < ReportBuilder

  def build_query
    wwpn=Wwpn

    unless @report.operating_system_type_ids.empty?
      wwpn=Wwpn.joins(server: :operating_system_type)
               .where(operating_system_types: { id: @report.operating_system_type_ids })
    end

    unless @report.customer_ids.empty?
      wwpn.joins(server: :customer)
          .where(customers: { id: @report.customer_ids } )
    end
  end

  def datatable_data(page, per_page)
    @wwpn_list=search_result.page(page).per_page(per_page).select("wwpns.id").map { |wwpn| wwpn.id }
    build_rows
  end

  def total_records
    Wwpn.count
  end

  def xlsx_data
    @wwpn_list=search_result.select("wwpns.id").map { |wwpn| wwpn.id }
    build_rows
  end


  def first_header
    "wwpn"
  end

  def server_request(field)
    Wwpn.joins(:server).find_all_by_id(@wwpn_list).map  do |wwpn|
      begin
        result=wwpn.server.send(field.select_attribute).to_s
      rescue
        result=""
      end
      @results[wwpn.wwpn][field.select_attribute]=result
    end
  end

  def san_infra_request(field)
    Wwpn.joins(:san_infra).find_all_by_id(@wwpn_list).map  do |wwpn|
      begin
        result=wwpn.san_infra.send(field.select_attribute).to_s
      rescue
        result=""
      end
      @results[wwpn.wwpn][field.select_attribute]=result
    end
  end

  def linux_port_request(field)
    Wwpn.joins(:linux_port).find_all_by_id(@wwpn_list).map  do |wwpn|
      begin
        result=wwpn.linux_port.send(field.select_attribute).to_s
      rescue
        result=""
      end
      @results[wwpn.wwpn][field.select_attribute]=result
    end
  end

  def server_attribute_request(field)
    Wwpn.joins(server: :server_attributes)
              .where(server_attributes: {name: field.select_attribute })
              .select("wwpn, server_attributes.output AS output")
              .find_all_by_id(@wwpn_list)
              .map do |wwpn|
                begin
                  result=wwpn.output.to_s
                rescue
                  result=""
                end
                @results[wwpn.wwpn][field.select_attribute]=result
              end
  end

  def build_rows
    #build result array
    report.report_fields.each do |field|
      send("#{field.association_type}_request",field)
    end

    Wwpn.select(:wwpn).find(@wwpn_list).map do |wwpn|
      row=[]
      row << wwpn.wwpn
      columns.each do |column|
        entry = @results[wwpn.wwpn][column] || ""
        row << entry
      end
      row
    end
  end






end
