class ServerAttributesController < ApplicationController
  load_and_authorize_resource
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

    @search = ServerAttribute.scoped_by_category("hcm").customer_scope(current_user.customer_scope).search(session[:last_query])
    @total_records = ServerAttribute.scoped_by_category("hcm").customer_scope(current_user.customer_scope).count

    @srv_attrs = @search.result

    @srv_attrs = @srv_attrs.joins(:server).order("#{sort_column} #{sort_direction}")
    @search.build_condition


    respond_to do |format|
      format.html # index.html.erb
      format.json {
        @secho = params[:sEcho].to_i
        @total_display_records = @srv_attrs.count
        @data = datatable_data
        }
      format.xlsx
    end
  end

  # GET /srv/1
  # GET /srvs/1.json
  def show
    @srv_attr = ServerAttribute.scoped_by_category("hcm").find(params[:id])
    @srv_attrs = @srv_attr.versions
    @srv_attrs = @srv_attrs.map{|x| x.reify}.select{|x| not x.nil?}.reverse
    @srv_attrs.insert(0,@srv_attr)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @srv_attrs }
    end
  end

  def history
    @srv_attr = ServerAttribute.scoped_by_category("hcm").find(params[:id])
    @srv_attrs = @srv_attr.versions
    @srv_attrs = @srv_attrs.map{|x| x.reify}.select{|x| not x.nil?}.reverse
    @srv_attrs.insert(0,@srv_attr)
  end

  private
  def datatable_data
    @srv_attrs.page(page).per_page(per_page).map do |srv_attr|
      [
        srv_attr.name,
        srv_attr.server.hostname,
        srv_attr.description,
        srv_attr.output,
        srv_attr.return_code,
        srv_attr.conf_errors
      ]
    end
  end

  def sort_column
    columns = %w[name servers.hostname description output info return_code hc_errors]
    columns[params[:iSortCol_0].to_i]
  end
end
