# -*- encoding : utf-8 -*-
class ServersController < ApplicationController
  load_and_authorize_resource
  # GET /servers
  # GET /servers.json
  def index
    if params[:clear].present?
      params[:q] = nil
      params[:sSearch]=nil
      session[:last_query] = nil
    end

    if params[:q].present?
      session[:last_query] = params[:q]
    elsif session[:last_query].present?
      params.merge( session[:last_query] )
    end

    if params[:export].present?
      redirect_to :action => 'index', :format => 'xlsx' 
      return
    end
    
    if current_user.customer_scope.present?
      @search = Server.scoped_by_customer(current_user.customer_scope).search(session[:last_query])
      @total_records = Server.scoped_by_customer(current_user.customer_scope).count
    else
      @search = Server.search(session[:last_query])
      @total_records = Server.count
    end
    @servers = @search.result

    if params[:sSearch].present?
      @servers = datatable_search
    end

    @servers = @servers.order("#{sort_column} #{sort_direction}")
    @search.build_condition

    
    respond_to do |format|
      format.html # index.html.erb
      format.json { 
        @secho = params[:sEcho].to_i
        @total_display_records = @servers.count
        @data = datatable_data
        }
      format.xlsx
    end
  end

  # GET /servers/1
  # GET /servers/1.json
  def show
    @server = Server.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @server }
    end
  end

  def quick_search
    if params[:type] == "hostname"
end

    @servers = @servers.order("#{sort_column} #{sort_direction}")
    @search.build_condition

    if params[:export].present?
      redirect_to '/servers.xlsx' 
      return
    end 
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { 
        @secho = params[:sEcho].to_i
        @total_display_records = @servers.count
        @data = datatable_data
        }
      format.xlsx
    end
  end

  # GET /servers/1
  # GET /servers/1.json
  def show
    @server = Server.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @server }
    end
  end

  def quick_search
    if params[:type] == "hostname"
      redirect_to(Server.where(:hostname => params[:search]).select("id").first)
    else
      redirect_to servers_path( :q => {"c" => {"0" =>{"a" =>{"0" =>{"name"=> params[:type] }}, "p"=>"eq", "v" =>{"0"=>{"value" => params[:search] }}}}})
    end
  end
private
  def datatable_data
    @servers.page(page).per_page(per_page).map do |server|
      [
        server.customer,
        server.hostname,
        server.os_version,
        server.os_type,
        server.global_image,
        server.install_date,
        server.sys_model,
        server.sys_serial,
        server.sys_fwversion
      ]
    end 
  end

  def datatable_search
    @servers.where("hostname like :search or customer like :search or os_version like :search or sys_model like :search or sys_serial like :search or sys_fwversion like :search", 
    search: "%#{params[:sSearch]}%")
  end

  def sort_column
    columns = %w[customer hostname os_version os_type global_image install_date sys_model sys_serial sys_fwversion]
    columns[params[:iSortCol_0].to_i]
  end
end
