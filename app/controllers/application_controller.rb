# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
 #   redirect_to contacts_url, :alert => "#{exception.message} + #{exception.action} + #{exception.subject}"
    redirect_to contacts_url, :alert => exception.message
  end
  
  def recommended_firmware(model)
    unless Firmware.find_by_model(model).nil?
      Firmware.find_by_model(model).recommended 
    else
      "Not found"
    end
  end
  
  private
  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
