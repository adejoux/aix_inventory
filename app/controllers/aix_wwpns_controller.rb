class AixWwpnsController < ApplicationController
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

    @search = Wwpn.server_type("AIX").customer_scope(current_user.customer_scope).search(session[:last_query])
    @total_records = Wwpn.server_type("AIX").customer_scope(current_user.customer_scope).count

    @wwpns = @search.result

    if params[:sSearch].present?
      @wwpns = datatable_search
    end

    @wwpns = @wwpns.order("#{sort_column} #{sort_direction}")
    @search.build_condition

    respond_to do |format|
      format.html # index.html.erb
      format.json {
        @secho = params[:sEcho].to_i
        @total_display_records = @wwpns.count
        @data = datatable_data
        }
      format.xlsx
    end
  end

  # GET /wwpns/1
  # GET /wwpns/1.json
  def show
    @wwpn = Wwpn.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wwpn }
    end
  end

  def view_logs
    @wwpn = Wwpn.find(params[:id])
  end

    private
  def datatable_data
    @wwpns.page(page).per_page(per_page).map do |wwpn|
      [
        wwpn.wwpn,
        wwpn.get_server("customer"),
        wwpn.get_server("hostname"),
        wwpn.get_server("run_date").to_s,
        wwpn.get_server("os_version"),
        wwpn.get_aix_port("name"),
        wwpn.get_server_attribute("sdd_driver"),
      ]
    end
  end

  def datatable_search
    @wwpns.where("wwpns.wwpn like :search or customer like :search or customer like :search or switch like :search or portname like :search or san_infras.port like :search",
    search: "%#{params[:sSearch]}%")
  end

  def sort_column
    columns = %w[wwpns.wwpn customer hostname switch portname port]
    columns[params[:iSortCol_0].to_i]
  end

  def get_sdd_driver(wwpn)
    if wwpn.server && wwpn.server.server_attributes.where( name: "sdd_driver").first
      wwpn.server.server_attributes.where( name: "sdd_driver").first.output
    else
      "N/F"
    end
  end

end
