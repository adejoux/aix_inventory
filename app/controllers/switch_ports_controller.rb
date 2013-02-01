# -*- encoding : utf-8 -*-
class SwitchPortsController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:clear].present?
      params[:q] = nil
      session[:san_last_query] = nil
    end

    if params[:q].present?
      session[:san_last_query] = params[:q]
    elsif session[:san_last_query].present?
      params.merge( session[:san_last_query] )
    end
    
    @search = SwitchPort.search(session[:san_last_query])
    @total_records = SwitchPort.count
    
    @switch_ports = @search.result

    if params[:sSearch].present?
      @switch_ports = datatable_search
    end

    @switch_ports = @switch_ports.order("#{sort_column} #{sort_direction}")
    @search.build_condition

    
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { 
        @secho = params[:sEcho].to_i
        @total_display_records = @switch_ports.count
        @data = datatable_data
      }
    end
  end

  def show
    @switch_port = SwitchPort.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @switch_port }
    end
  end
  
private
  def datatable_data
    @switch_ports.page(page).per_page(per_page).map do |switch_port|
       [
         switch_port.fabric,
         switch_port.domain,
         switch_port.port,
         switch_port.port_alias,
         switch_port.wwpn
      ]
    end
  end  
  def datatable_search
      @switch_ports.where("fabric like :search or domain like :search or port like :search or wwpn like :search or port_alias like :search", search: "%#{params[:sSearch]}%")
  end
    
  def sort_column
      columns = %w[fabric domain port wwpn port_alias]
      columns[params[:iSortCol_0].to_i]
  end
end
