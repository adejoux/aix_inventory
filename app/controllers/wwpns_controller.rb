class WwpnsController < ApplicationController
  load_and_authorize_resource

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
    
    @search = Wwpn.search(session[:last_query])
    @total_records = Wwpn.count

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
        wwpn.san_port.fabric,
        wwpn.switch,
        wwpn.speed,
        wwpn.status,
        wwpn.portname,
        wwpn.mode,
        wwpn.id
      ]
    end 
  end

  def datatable_search
    @wwpns.where("infra like :search or fabric like :search or switch like :search or speed like :search or status like :search or portname like :search or mode like :search", 
    search: "%#{params[:sSearch]}%")
  end

  def sort_column
    columns = %w[infra fabric switch speed status portname mode]
    columns[params[:iSortCol_0].to_i]
  end
end