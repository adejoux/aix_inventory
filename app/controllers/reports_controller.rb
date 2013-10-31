class ReportsController < ApplicationController
  load_and_authorize_resource
  def index
    @reports=Report.where(user_id: [ User.where( role: "admin").pluck(:id), current_user.id ] )
  end

  def show
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

    report = Report.find(params[:id])

    @report_builder=ReportBuilder.build(report, session[:last_query])
    @search = @report_builder.search
    @columns= @report_builder.columns

    @report_builder.build_search_condition

    respond_to do |format|
      format.html
      format.json {
        @secho = params[:sEcho].to_i
        @data = @report_builder.datatable_data(page, per_page)
        @total_records = @report_builder.total_records
        @total_display_records = @report_builder.total_display_records
      }
      format.xlsx {
        @first_header = @report_builder.first_header
        @data = @report_builder.xlsx_data
      }
    end
  end

  def new

    render status: 403 unless Report::TYPES.include? params[:report_type]
    @report=Report.new(report_type: params[:report_type])


    respond_to do |format|
      format.html
    end
  end

  def create
    @report = Report.new(params[:report])
    @report.user_id = current_user.id

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'report was successfully created.' }
        format.json { render json: @report, status: :created, location: @report }
      else
        format.html { render action: "new" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @firmware = Report.find(params[:id])
  end

  def server_link
    server=Server.find_by_hostname(params[:name])
    redirect_to server_path(server)
  end

  # PUT /report/1
  # PUT /report/1.json
  def update
    @report = Report.find(params[:id])

    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_url }
      format.json { head :no_content }
    end
  end


end


