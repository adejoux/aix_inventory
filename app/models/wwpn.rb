class Wwpn < ActiveRecord::Base
  attr_accessible :wwpn, :san_infra_id
  validates_uniqueness_of :wwpn
  validates_presence_of :wwpn
  has_one :aix_port, :dependent => :destroy, :autosave => true
  has_one :linux_port, :dependent => :destroy, :autosave => true
  belongs_to :server
  delegate :server_attributes, :to => :server
  belongs_to :san_infra
  has_many :activities, as: :trackable, :autosave => true


  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "id", "server_id"]

  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

  def self.server_type(type)
    includes(:server => :server_attributes).where("servers.os_type = ?", type)
  end
end
