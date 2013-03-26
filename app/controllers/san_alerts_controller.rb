class SanAlertsController < ApplicationController
  load_and_authorize_resource
  # GET /san_alerts
  # GET /san_alerts.json
  def index
    @san_alerts = SanAlert.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @san_alerts }
    end
  end

  # GET /san_alerts/1
  # GET /san_alerts/1.json
  def show
    @san_alert = SanAlert.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @san_alert }
    end
  end

  # GET /san_alerts/new
  # GET /san_alerts/new.json
  def new
    @san_alert = SanAlert.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @san_alert }
    end
  end

  # GET /san_alerts/1/edit
  def edit
    @san_alert = SanAlert.find(params[:id])
  end

  # POST /san_alerts
  # POST /san_alerts.json
  def create
    @san_alert = SanAlert.new(params[:san_alert])

    respond_to do |format|
      if @san_alert.save
        Rails.cache.clear
        format.html { redirect_to @san_alert, notice: 'San alert was successfully created.' }
        format.json { render json: @san_alert, status: :created, location: @san_alert }
      else
        format.html { render action: "new" }
        format.json { render json: @san_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /san_alerts/1
  # PUT /san_alerts/1.json
  def update
    @san_alert = SanAlert.find(params[:id])

    respond_to do |format|
      Rails.cache.clear
      if @san_alert.update_attributes(params[:san_alert])
        format.html { redirect_to @san_alert, notice: 'San alert was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @san_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /san_alerts/1
  # DELETE /san_alerts/1.json
  def destroy
    @san_alert = SanAlert.find(params[:id])
    @san_alert.destroy
    Rails.cache.clear
    
    respond_to do |format|
      format.html { redirect_to san_alerts_url }
      format.json { head :no_content }
    end
  end
end
