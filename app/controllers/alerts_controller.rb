class AlertsController < ApplicationController
  load_and_authorize_resource :san_alert, :parent => false
  def san_alerts
    @alerts=SanAlert.all
  end
  
  def aix_alerts
    @alerts=AixAlert.all
    @total_records=0
    @total_display_records=0
    respond_to do |format|
      format.html # index.html.erb
      format.json { 
        @secho = params[:sEcho].to_i
        @data = datatable_data[(page - 1) * per_page, per_page]
        }
      format.xlsx
    end
  end
private  

  #TODO : make a more clean method
  def datatable_data
    
    result=[]
    @alerts.each do |alert|
      
      if params[:sSearch].present?
        @servers = Server.aix_alerts_search("%#{params[:sSearch]}%").retrieve_aix_invalid_status(alert.check, alert.valid_status)
      else
        @servers = Server.retrieve_aix_invalid_status(alert.check, alert.valid_status)
      end
      @total_records+=Server.retrieve_aix_invalid_status(alert.check, alert.valid_status).count
      @total_display_records+=@servers.count
      result += @servers.map do |server|
          [
            server.customer,
            server.hostname,
            server.healthcheck,
            server.status
          ]
        end
    end 
    result
  end
end
