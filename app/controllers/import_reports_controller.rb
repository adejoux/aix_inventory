class ImportReportsController < ApplicationController
  load_and_authorize_resource
  def index
   @import_reports = ImportReport.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @import_reports }
    end
  end
  def show
    @import_report = ImportReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @import_report }
    end
  end
end
