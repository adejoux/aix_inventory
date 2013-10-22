# -*- encoding : utf-8 -*-
class ServersController < ApplicationController
  load_and_authorize_resource

  # GET /servers/1
  # GET /servers/1.json
  def show
    @server = Server.includes(:health_checks).includes(:softwares).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @server }
    end
  end

  def quick_search
    if params[:type] == "hostname"
      redirect_to(Server.where(:hostname => params[:search]).select("id").first)
    else
      redirect_to servers_path( :q => {"c" => {"0" =>{"a" =>{"0" =>{"name"=> params[:type] }}, "p"=>"eq", "v" =>{"0"=>{"value" => params[:search] }}}}})
    end
  end

  # GET /servers/1/edit
  def edit
    @server = Server.find(params[:id])
  end
  # PUT /servers/1
  # PUT /servers/1.json
  def update
    @server = Server.find(params[:id])

    respond_to do |format|
      if @server.update_attributes(params[:server])
        format.html { redirect_to @server, notice: 'Server was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end
end
