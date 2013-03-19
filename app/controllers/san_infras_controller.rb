class SanInfrasController < ApplicationController
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
    
    @search = SanInfra.search(session[:last_query])
    @total_records = SanInfra.count

    @san_infras = @search.result

    if params[:sSearch].present?
      @san_infras = datatable_search
    end

    @san_infras = @san_infras.order("#{sort_column} #{sort_direction}")
    @search.build_condition

    
    respond_to do |format|
      format.html # index.html.erb
      format.json { 
        @secho = params[:sEcho].to_i
        @total_display_records = @san_infras.count
        @data = datatable_data
        }
      format.xlsx
    end
  end

  # GET /san_infras/1
  # GET /san_infras/1.json
  def show
    @san_infra = SanInfra.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @san_infra }
    end
  end

  def view_logs
    @san_infra = SanInfra.find(params[:id])
  end

    private
  def datatable_data
    @san_infras.page(page).per_page(per_page).map do |san_infra|
      [
        san_infra.infra,
        san_infra.fabric,
        san_infra.switch,
        san_infra.speed,
        san_infra.status,
        san_infra.portname,
        san_infra.mode,
        san_infra.id
      ]
    end 
  end

  def datatable_search
    @san_infras.where("infra like :search or fabric like :search or switch like :search or speed like :search or status like :search or portname like :search or mode like :search", 
    search: "%#{params[:sSearch]}%")
  end

  def sort_column
    columns = %w[infra fabric switch speed status portname mode]
    columns[params[:iSortCol_0].to_i]
  end
end
