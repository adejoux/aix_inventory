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

    @search = Server.customer_scope(current_user.customer_scope).search(session[:last_query])
    @total_records = Server.customer_scope(current_user.customer_scope).count

    @servers = @search.result

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
    @server = Server.includes(:healthchecks).includes(:san_infras).includes(:softwares).find(params[:id])

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

  # GET /servers/1/edit
  def edit
    @server = Server.find(params[:id])
  end
  # PUT /servers/1
  # PUT /servers/1.json
  def update
    @server = Server.find(params[:id])

    respond_to do |format|
      if @server.update_attributes(params[:server])
        format.html { redirect_to @server, notice: 'Server was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end
  private
  def datatable_data
    @servers.page(page).per_page(per_page).map do |server|
      [
        server.customer,
        server.hostname,
        server.os_type,
        server.os_version,
        server.run_date.to_s
      ]
    end
  end

  def sort_column
    columns = %w[customer hostname os_type os_version run_date]
    columns[params[:iSortCol_0].to_i]
  end
end
