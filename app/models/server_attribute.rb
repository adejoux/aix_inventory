class ServerAttribute < ActiveRecord::Base
  attr_accessible :category, :conf_errors, :description, :name, :output, :return_code, :server_id
  belongs_to :server
  has_paper_trail :only => [:name, :description, :category, :conf_errors, :output, :return_code]
  has_many :activities, as: :trackable, :autosave => true, :dependent => :destroy

  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "id", "server_id"]

  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

  def self.customer_scope(customer)
    unless customer.nil? or customer.empty?
      joins(:server).where("servers.customer = ?", customer)
    else
      scoped
    end
  end
end
