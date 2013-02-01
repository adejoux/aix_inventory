# -*- encoding : utf-8 -*-
class FirmwaresController < ApplicationController
  load_and_authorize_resource
  # GET /firmwares
  # GET /firmwares.json
  def index
    @firmwares = Firmware.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @firmwares }
    end
  end

  # GET /firmwares/1
  # GET /firmwares/1.json
  def show
    @firmware = Firmware.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @firmware }
    end
  end

  # GET /firmwares/new
  # GET /firmwares/new.json
  def new
    @firmware = Firmware.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @firmware }
    end
  end

  # GET /firmwares/1/edit
  def edit
    @firmware = Firmware.find(params[:id])
  end

  # POST /firmwares
  # POST /firmwares.json
  def create
    @firmware = Firmware.new(params[:firmware])

    respond_to do |format|
      if @firmware.save
        format.html { redirect_to @firmware, notice: 'Firmware was successfully created.' }
        format.json { render json: @firmware, status: :created, location: @firmware }
      else
        format.html { render action: "new" }
        format.json { render json: @firmware.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /firmwares/1
  # PUT /firmwares/1.json
  def update
    @firmware = Firmware.find(params[:id])

    respond_to do |format|
      if @firmware.update_attributes(params[:firmware])
        format.html { redirect_to @firmware, notice: 'Firmware was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @firmware.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /firmwares/1
  # DELETE /firmwares/1.json
  def destroy
    @firmware = Firmware.find(params[:id])
    @firmware.destroy

    respond_to do |format|
      format.html { redirect_to firmwares_url }
      format.json { head :no_content }
    end
  end
end
