module AlertsHelper
  def fabric_alerts(fabric1, fabric2)
    #to avoid cache problem in development mode
    @server=Server
    Rails.cache.fetch([fabric1, fabric2]) do
      Server.not_in_both_fabrics(fabric1, fabric2)
    end
  end

end
