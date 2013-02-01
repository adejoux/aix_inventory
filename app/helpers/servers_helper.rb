# -*- encoding : utf-8 -*-
module ServersHelper
  def reset_link_to
    params[:q] = nil
    session[:last_query] = nil
    link_to "Reset", servers_path( :params => nil), :class => "btn btn-error"
  end
end
