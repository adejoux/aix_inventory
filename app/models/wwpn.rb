class Wwpn < ActiveRecord::Base
  attr_accessible :san_infra_id, :aix_port_id, :sod_infra_id, :wwpn
  validates_uniqueness_of :wwpn
  belongs_to :aix_port
  belongs_to :san_infra

  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "id", "aix_port_id", "san_infra_id", "sod_infra_id"]
  
  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
