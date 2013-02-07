# -*- encoding : utf-8 -*-
class StatisticsController < ApplicationController
  load_and_authorize_resource :server, :parent => false
  def general
  end
  
  def customer
  end
  
  def render_stats
    @stat = params[:stats] if ['release_stats', 'customer_stats', 'model_stats', 'customer_release_stats', 'customer_model_stats'].include? params[:stats]
    respond_to do | format |  
        format.js {render :layout => false}  
    end
  end
end
