# -*- encoding : utf-8 -*-
module StatisticsHelper

  
  def customers_table_data
    Rails.cache.fetch("sys_customers_data") do
      Server.customers_data
    end
  end
  
  def customers_chart_data
    customers_table_data.map do |entry|
      {
        customer: entry[0],
        servers_count: entry[1]
      }
    end
  end
  
  def releases_table_data
    Rails.cache.fetch("sys_releases_data") do
      Server.releases_data
    end
  end
  
    def releases_chart_data
      releases_table_data.map do |entry|
      {
        release: entry[0],
        servers_count: entry[1]
      }
    end
  end
  
  def models_table_data
    Rails.cache.fetch("sys_models_data") do
      Server.sys_models_data
    end
  end
   
  def models_chart_data
     models_table_data.each do |entry|
      {
        model: entry.sys_model,
        count_sys_serial: entry.count_sys_serial
      }
    end
  end
  
  def customer_releases_table_data
    Server.scoped_by_customer(current_user.customer_scope).releases_data
  end
  
  def customer_models_table_data
    Server.scoped_by_customer(current_user.customer_scope).sys_models_data
  end
  
  def customer_models_chart_data
    Server.scoped_by_customer(current_user.customer_scope).sys_models_data.map do |entry|
      {
        label:  entry.sys_model, value: entry.count_sys_serial
      }
    end
  end
  
  def customer_releases_chart_data
    Server.scoped_by_customer(current_user.customer_scope).releases_data.map do |entry|
      {
        label: entry[0], value: entry[1]
      }
    end
  end
end
