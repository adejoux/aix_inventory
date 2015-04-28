class CleanDataWorker

  def clean_servers
    Activity.where(trackable_type: "Server").not_updated_since(Time.now - 3.days).find_each do |activity|
      begin
        activity.trackable.destroy
      rescue
      end
    end
  end

  def clean_server_datas
    Activity.not_updated_since(Time.now - 3.days).find_each do |activity|
      begin
        activity.trackable.destroy
      rescue
      end
    end
  end

  def perform
    clean_servers
    clean_server_datas
    Rails.cache.clear
  end
end
