module AlertsHelper
  def fabric_alerts(fabric1, fabric2)
    #to avoid cache problem in development mode
    @server=Server
    if current_user.customer_scope.nil?
	    Rails.cache.fetch([fabric1, fabric2]) do
	      Server.not_in_both_fabrics(fabric1, fabric2)
	    end
	  else
	  	Rails.cache.fetch([current_user.customer_scope, fabric1, fabric2]) do
	  		Server.scoped_by_customer(current_user.customer_scope).not_in_both_fabrics(fabric1, fabric2)
	  	end
	  end  
  end

end
