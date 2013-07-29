# -*- encoding : utf-8 -*-
class HardwaresController < ApplicationController
  #load_and_authorize_resource :server, :parent => false

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

    @search=Hardware.includes(:servers)
    if current_user.customer_scope.present?
      @search = @search.customer_scope(current_user.customer_scope).search(session[:hw_last_query])
      @total_records = Hardware.customer_scope(current_user.customer_scope).count
    else
      @search = @search.search(session[:hw_last_query])
      @total_records = Hardware.count
    end
    @hardwares = @search.result

    @search.build_condition

    respond_to do |format|
      format.html # hardware.html.erb
      format.json {
         @secho = params[:sEcho].to_i
         @total_display_records = @hardwares.count
         @data = datatable_data
      }
      format.xlsx { @hardwares }
    end
  end

private
  def datatable_data
     @hardwares.limit(per_page).offset((page - 1)*per_page).map do |hardware|
        [
          hardware.servers.map { |srv| srv.customer }.uniq,
          hardware.sys_model,
          hardware.serial,
          hardware.firmware,
          recommended_firmware(hardware.firmware),
          hardware.servers.count
        ]
     end
  end
end
