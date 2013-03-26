class AixAlertsController < ApplicationController
  # GET /aix_alerts
  # GET /aix_alerts.json
  def index
    @aix_alerts = AixAlert.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @aix_alerts }
    end
  end

  # GET /aix_alerts/1
  # GET /aix_alerts/1.json
  def show
    @aix_alert = AixAlert.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @aix_alert }
    end
  end

  # GET /aix_alerts/new
  # GET /aix_alerts/new.json
  def new
    @aix_alert = AixAlert.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @aix_alert }
    end
  end

  # GET /aix_alerts/1/edit
  def edit
    @aix_alert = AixAlert.find(params[:id])
  end

  # POST /aix_alerts
  # POST /aix_alerts.json
  def create
    @aix_alert = AixAlert.new(params[:aix_alert])

    respond_to do |format|
      if @aix_alert.save
        Rails.cache.clear
        format.html { redirect_to @aix_alert, notice: 'Aix alert was successfully created.' }
        format.json { render json: @aix_alert, status: :created, location: @aix_alert }
      else
        format.html { render action: "new" }
        format.json { render json: @aix_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /aix_alerts/1
  # PUT /aix_alerts/1.json
  def update
    @aix_alert = AixAlert.find(params[:id])

    respond_to do |format|
      if @aix_alert.update_attributes(params[:aix_alert])
        Rails.cache.clear
        format.html { redirect_to @aix_alert, notice: 'Aix alert was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @aix_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aix_alerts/1
  # DELETE /aix_alerts/1.json
  def destroy
    @aix_alert = AixAlert.find(params[:id])
    @aix_alert.destroy

    respond_to do |format|
      format.html { redirect_to aix_alerts_url }
      format.json { head :no_content }
    end
  end
end
