class CleanDataWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def clean_servers
    Activity.where(trackable_type: "Server").not_updated_since(Time.now - 5.days).each do |activity|
    activity.trackable.destroy
    end
  end

  def clean_server_datas
    Activity.not_updated_since(Time.now - 5.days).each do |activity|
      activity.trackable.destroy
    end
  end

  def perform
    clean_servers
    clean_server_datas
    Rails.cache.clear
  end
end
