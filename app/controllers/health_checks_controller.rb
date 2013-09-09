class HealthChecksController < ApplicationController
  # GET /health_checks
  # GET /health_checks.json
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

    @search = HealthCheck.customer_scope(current_user.customer_scope).search(session[:last_query])
    @total_records = HealthCheck.customer_scope(current_user.customer_scope).count

    @hcs = @search.result

    @hcs = @hcs.joins(:server).order("#{sort_column} #{sort_direction}")
    @search.build_condition


    respond_to do |format|
      format.html # index.html.erb
      format.json {
        @secho = params[:sEcho].to_i
        @total_display_records = @hcs.count
        @data = datatable_data
        }
      format.xlsx
    end
  end

  # GET /srv/1
  # GET /srvs/1.json
  def show
    @hc = HealthCheck.find(params[:id])
    @hcs = @hc.versions
    @hcs = @hcs.map{|x| x.reify}.select{|x| not x.nil?}.reverse
    @hcs.insert(0,@hc)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hcs }
    end
  end

  def history
    @hc = HealthCheck.find(params[:id])
    @hcs = @hc.versions
    @hcs = @hcs.map{|x| x.reify}.select{|x| not x.nil?}.reverse
    @hcs.insert(0,@hc)
  end

  private
  def datatable_data
    @hcs.page(page).per_page(per_page).map do |hc|
      [
        hc.name,
        hc.server.hostname,
        hc.description,
        hc.output,
        hc.info,
        hc.return_code,
        hc.hc_errors
      ]
    end
  end

  def sort_column
    columns = %w[name servers.hostname description output info return_code hc_errors]
    columns[params[:iSortCol_0].to_i]
  end
end
