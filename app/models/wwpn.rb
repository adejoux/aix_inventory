class Wwpn < ActiveRecord::Base
  attr_accessible :wwpn
  validates_uniqueness_of :wwpn
  validates_presence_of :wwpn
  has_one :aix_port, :autosave => true
  has_one :san_infra
  has_one :linux_port, :autosave => true
  has_one :aix_port
  belongs_to :server
  has_many :activities, as: :trackable, :autosave => true


  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "id", "server_id"]

  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

  def self.datatable_query
  	joins('LEFT OUTER JOIN `aix_ports` ON `aix_ports`.`id` = `wwpns`.`aix_port_id` LEFT OUTER JOIN `servers` ON `servers`.`id` = `aix_ports`.`server_id`')
  	.joins('LEFT OUTER JOIN san_infras ON san_infras.id = wwpns.san_infra_id')
    .select('wwpns.aix_port_id, servers.os_version as os_version, wwpns.wwpn, servers.customer as customer, servers.hostname as hostname,
             san_infras.switch as switch, san_infras.portname as portname, san_infras.port as port ')
  end
end
