class UploadsController < ApplicationController
  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all
  
    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @uploads.map{|upload| upload.to_jq_upload } }
    end
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
    @upload = Upload.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @upload }
    end
  end

  # GET /uploads/new
  # GET /uploads/new.json
  def new
    @upload = Upload.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @upload }
    end
  end

  # GET /uploads/1/edit
  def edit
    @upload = Upload.find(params[:id])
  end

  # GET/uploads/import/1
  def import
    @upload = Upload.find(params[:id])
    @upload.importing!
    redirect_to :uploads
  end

  # POST /uploads
  # POST /uploads.json
  def create
    # TO DO: make it cleaner
    if params[:commit] == "Delete"
      logger.debug "ici toto"
       Upload.destroy_all( {id: params[:upload_ids] } )
      redirect_to uploads_url, :notice => "uploaded files deleted"
      return
    end
    respond_to do |format|
      format.html { redirect_to uploads_url, alert: "Nothing to upload" }
      format.js  {@upload = Upload.create(params[:upload])}
    end
  end

  # PUT /uploads/1
  # PUT /uploads/1.json
  def update
    @upload = Upload.find(params[:id])

    respond_to do |format|
      if @upload.update_attributes(params[:upload])
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  def view_logs
    @upload = Upload.find(params[:id])
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    unless params[:upload_ids].nil? or params[:upload_ids].empty?
      Upload.destroy_all( {id: params[:upload_ids] } )
      redirect_to uploads_url, :notice => "uploaded files deleted"
    end
    
    @upload = Upload.find(params[:id])
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end
end
