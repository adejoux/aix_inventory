# -*- encoding : utf-8 -*-
class HardwaresController < ApplicationController
  load_and_authorize_resource :server, :parent => false

  def index
    if params[:clear].present?
      params[:q] = nil
      session[:hw_last_query] = nil
    end

    if params[:q].present?
      session[:hw_last_query] = params[:q]
    elsif session[:hw_last_query].present?
      params.merge( session[:hw_last_query] )
    end
    
    if params[:export].present?
      redirect_to :action => 'index', :format => 'xlsx' 
      return
    end
    
    if current_user.customer_scope.present?
      @search = Server.scoped_by_customer(current_user.customer_scope).search(session[:hw_last_query])
      @total_records = Server.scoped_by_customer(current_user.customer_scope).group(:sys_model, :sys_fwversion, :sys_serial).count(:hostname).count
    else
      @search = Server.search(session[:hw_last_query])
      @total_records = Server.group(:sys_model, :sys_fwversion, :sys_serial).count(:hostname).count
    end
    @servers = @search.result

    if params[:sSearch].present?
      @servers = datatable_search
    end

    @customer_hash ||= customer_hash
    @servers = @servers.group( :sys_model, :sys_fwversion, :sys_serial)
    @search.build_condition
    
    respond_to do |format|
      format.html # hardware.html.erb
      format.json { 
         @secho = params[:sEcho].to_i
         @total_display_records = @servers.count(:hostname).count
         @data = datatable_data
      }
      format.xlsx { @hardwares = @servers.count(:hostname) }
    end
  end
  
private
  def datatable_data
     @servers.limit(per_page).offset((page - 1)*per_page).count(:hostname).map do |entry|
     	     next if  entry.nil? or entry[0][0].nil?
        [
          @customer_hash[entry[0][2]].to_sentence,
          entry[0][0],
          entry[0][1],
          recommended_firmware(entry[0][0]),
          entry[0][2],
          entry[1].to_s
        ]
     end
  end
  def datatable_search
     @servers.where(" customer like :search or sys_model like :search or sys_serial like :search or sys_fwversion like :search", search: "%#{params[:sSearch]}%")
  end
  
  def customer_hash
    cust_hash = Hash.new {|h,k| h[k] = [] }
    Server.select("customer, sys_serial").uniq.map {  |entry| cust_hash[entry.sys_serial] << entry.customer }
    cust_hash
  end
end
