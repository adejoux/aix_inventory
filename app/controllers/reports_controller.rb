class ReportsController < ApplicationController
  load_and_authorize_resource
  def index
    @reports=Report.all
  end

  def show
    @report = Report.find(params[:id])
    @columns=@report.report_fields.select("select_attribute").map { |rq| rq.select_attribute }
    @total_records = Server.customer_scope(current_user.customer_scope).count

    respond_to do |format|
      format.html # show.html.haml
      format.json {
        @secho = params[:sEcho].to_i
        @data=datatable_data }
      format.xlsx { @data=xlsx_data }
    end
  end

  def new
    @report=Report.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @report }
    end
  end

  def create
    @report = Report.new(params[:report])

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


  # PUT /report/1
  # PUT /report/1.json
  def update
    @report = Report.find(params[:id])

    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to @report, notice: 'Firmware was successfully updated.' }
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

  def load_form
    render status: 403 unless Report::TYPES.include? params[:form]
    @form = params[:form] + "_form"
  end

  private
  def datatable_data
    server_list=Server.customer_scope(current_user.customer_scope).page(page).per_page(per_page)
    build_rows(server_list)
  end

  def xlsx_data
    server_list=Server.customer_scope(current_user.customer_scope)
    @first_header="server"
    build_rows(server_list)
  end

  def build_rows(server_list)
    #build result array
    results=Hash.new{|hash, key| hash[key] = Hash.new}
    @report.report_fields.each do |field|
      case field.association_type
        when "server_attribute"
          ServerAttribute.where(name: field.select_attribute).joins(:server).find_all_by_server_id(server_list.map { |srv| srv.id }).map { |res| results[res.server.hostname][res.name]=res.output }
        when "server"
          Server.find(server_list.map { |srv| srv.id}).map { |res| results[res.hostname][field.select_attribute]=res.send(field.select_attribute)}
      end
    end

    servers=results.keys

    server_list.map do |server|
      row=[]
      row << server.hostname
      @columns.each do |column|
        entry = results[server.hostname][column] || ""
        row << entry
      end
      row
    end
  end
end
