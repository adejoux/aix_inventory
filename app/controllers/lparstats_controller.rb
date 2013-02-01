# -*- encoding : utf-8 -*-
class LparstatsController < ApplicationController
  load_and_authorize_resource	
  def index
    if params[:clear].present?
      params[:q] = nil
      session[:lpar_last_query] = nil
    end

    if params[:q].present?
      session[:lpar_last_query] = params[:q]
    elsif session[:lpar_last_query].present?
      params.merge( session[:lpar_last_query] )
    end
    
    if params[:export].present?
      redirect_to :action => 'index', :format => 'xlsx' 
      return
    end
    
    if current_user.customer_scope.present?
      @search = Lparstat.scoped_customer(current_user.customer_scope).search(session[:last_query])
      @total_records = Lparstat.scoped_customer(current_user.customer_scope).count
    else
      @search = Lparstat.joins(:server).search(session[:lpar_last_query])
      @total_records = Lparstat.count
    end
  
    @lparstats = @search.result

    if params[:sSearch].present?
      @lparstats = datatable_search
    end

    @lparstats = @lparstats.order("#{sort_column} #{sort_direction}")
    @search.build_condition
    
    respond_to do |format|
       format.html # index.html.erb
       format.json {  
         @secho = params[:sEcho].to_i
         @total_display_records = @lparstats.count
         @data = datatable_data 
       }
       format.xlsx
    end
  end

private
  def datatable_data
    @lparstats.page(page).per_page(per_page).map do |lparstat|
      [
        lparstat.server.customer,
        lparstat.server.sys_model,
        lparstat.server.sys_serial,
        lparstat.partition_name,
        lparstat.lpar_type,
        lparstat.mode,
        lparstat.online_virtual_cpus.to_s,
        lparstat.entitled_capacity.to_s,
        lparstat.online_memory.to_s,
        lparstat.minimum_virtual_cpus.to_s,
        lparstat.desired_virtual_cpus.to_s,
        lparstat.maximum_virtual_cpus.to_s,
        lparstat.minimum_capacity.to_s,
        lparstat.desired_capacity.to_s,
        lparstat.maximum_capacity.to_s,
        lparstat.minimum_memory.to_s,
        lparstat.desired_memory.to_s,
        lparstat.maximum_memory.to_s
      ]
    end
  end

  def datatable_search
    @lparstats.where("partition_name like :search or customer like :search or mode like :search", search: "%#{params[:sSearch]}%")
  end
  
  def sort_column
    columns = %w[servers.customer servers.model servers.sys_serial partition_name lpar_type mode online_virtual_cpus entitled_capacity online_memory minimum_virtual_cpus desired_virtual_cpus maximum_virtual_cpus minimum_capacity desired_capacity maximum_capacity minimum_memory desired_memory maximum_memory]
    columns[params[:iSortCol_0].to_i]
  end
end
