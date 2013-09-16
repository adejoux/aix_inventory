# -*- encoding : utf-8 -*-
class HardwaresController < ApplicationController
  #load_and_authorize_resource :server, :parent => false
  load_and_authorize_resource
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

    @search = Hardware.customer_scope(current_user.customer_scope).search(session[:hw_last_query])
    @total_records = Hardware.customer_scope(current_user.customer_scope).count

    @hardwares = @search.result

    @search.build_condition

    respond_to do |format|
      format.html # hardware.html.erb
      format.json {
         @secho = params[:sEcho].to_i
         @total_display_records = @hardwares.count
         @data = datatable_data
      }
      format.xlsx
    end
  end

private
  def datatable_data
     @hardwares.page(page).per_page(per_page).map do |hardware|
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
