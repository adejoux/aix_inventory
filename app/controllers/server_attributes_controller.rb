class ServerAttributesController < ApplicationController
  # GET /server_attributes
  # GET /server_attributes.json
  def index
    @server_attributes = ServerAttribute.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @server_attributes }
    end
  end

  # GET /server_attributes/1
  # GET /server_attributes/1.json
  def show
    @server_attribute = ServerAttribute.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @server_attribute }
    end
  end

  # GET /server_attributes/new
  # GET /server_attributes/new.json
  def new
    @server_attribute = ServerAttribute.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @server_attribute }
    end
  end

  # GET /server_attributes/1/edit
  def edit
    @server_attribute = ServerAttribute.find(params[:id])
  end

  # POST /server_attributes
  # POST /server_attributes.json
  def create
    @server_attribute = ServerAttribute.new(params[:server_attribute])

    respond_to do |format|
      if @server_attribute.save
        format.html { redirect_to @server_attribute, notice: 'Server attribute was successfully created.' }
        format.json { render json: @server_attribute, status: :created, location: @server_attribute }
      else
        format.html { render action: "new" }
        format.json { render json: @server_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /server_attributes/1
  # PUT /server_attributes/1.json
  def update
    @server_attribute = ServerAttribute.find(params[:id])

    respond_to do |format|
      if @server_attribute.update_attributes(params[:server_attribute])
        format.html { redirect_to @server_attribute, notice: 'Server attribute was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @server_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /server_attributes/1
  # DELETE /server_attributes/1.json
  def destroy
    @server_attribute = ServerAttribute.find(params[:id])
    @server_attribute.destroy

    respond_to do |format|
      format.html { redirect_to server_attributes_url }
      format.json { head :no_content }
    end
  end
end
