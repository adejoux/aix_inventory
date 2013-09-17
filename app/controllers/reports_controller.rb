class ReportsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @report=Report.new
    @report.report_queries.build

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
end
