class HealthChecksController < ApplicationController
  # GET /health_checks
  # GET /health_checks.json
   def index
    @hcs = HealthCheck.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: HealthCheck.all }
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
end
