# == Schema Information
#
# Table name: health_checks
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  return_code :integer
#  output      :text
#  hc_errors   :text
#  server_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  info        :text
#

class HealthCheck < ActiveRecord::Base
  attr_accessible :description, :hc_errors, :name, :info, :output, :return_code
  belongs_to :server
  has_many :activities, as: :trackable, :autosave => true, :dependent => :destroy

  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "id", "server_id"]

  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

  def self.find_by_server_and_check(server_id, check)
    where('"server_id" = ? and "check" = ?', server_id, check).first
  end

  def self.customer_scope(customer)
    unless customer.nil? or customer.empty?
      joins(:server).where("servers.customer = ?", customer)
    else
      scoped
    end
  end
end
