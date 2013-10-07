class Wwpn < ActiveRecord::Base
  attr_accessible :wwpn, :san_infra_id
  validates_uniqueness_of :wwpn
  validates_presence_of :wwpn
  has_one :aix_port, :dependent => :destroy, :autosave => true
  has_one :linux_port, :dependent => :destroy, :autosave => true
  belongs_to :server
  belongs_to :san_infra
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

  def get_server_attribute(attribute)
    begin
      server.server_attributes.where( name: attribute).first.output
    rescue
      "N/F"
    end
  end

  def get_server(attribute)
    begin
      server.send(attribute).to_s
    rescue
      "N/F"
    end
  end

  def get_linux_port(attribute)
    begin
      linux_port.send(attribute).to_s
    rescue
      "N/F"
    end
  end

  def get_aix_port(attribute)
    begin
      aix_port.send(attribute).to_s
    rescue
      "N/F"
    end
  end

  def self.customer_scope(customer)
    unless customer.nil? or customer.empty?
      joins(:server).where("servers.customer = ?", customer)
    else
      scoped
    end
  end

  def self.server_type(type)
      joins(:server).where("servers.os_type = ?", type)
  end
end
