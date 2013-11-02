# -*- encoding : utf-8 -*-
module StatisticsHelper


  def customers_table_data
    Server.customers_data
  end

  def customers_chart_data
    customers_table_data.map do |entry|
      {
        customer: entry[0].name,
        servers_count: entry[1]
      }
    end
  end

  def releases_table_data
    Server.releases_data
  end

    def releases_chart_data
      releases_table_data.map do |entry|
      {
        release: entry[0].release,
        servers_count: entry[1]
      }
    end
  end

  def models_table_data
    Hardware.group("sys_model").select("sys_model, count(distinct serial) as count_serial")
  end

  def models_chart_data
     models_table_data.each do |entry|
      {
        model: entry.sys_model,
        count_sys_serial: entry.count_serial
      }
    end
  end
end
