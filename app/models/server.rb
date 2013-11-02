# == Schema Information
#
# Table name: servers
#
#  id                       :integer          not null, primary key
#  hostname                 :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  run_date                 :date
#  hardware_id              :integer
#  customer_id              :integer
#  operating_system_type_id :integer
#  operating_system_id      :integer
#

# -*- encoding : utf-8 -*-
class Server < ActiveRecord::Base
  has_many :aix_paths, :dependent => :destroy, :autosave => true
  has_many :linux_security_fixes, :dependent => :destroy, :autosave => true
  has_many :health_checks, :dependent => :destroy, :autosave => true
  has_many :volume_groups, :dependent => :destroy, :autosave => true
  has_many :file_systems, :dependent => :destroy, :autosave => true
  has_many :ip_addresses, :dependent => :destroy, :autosave => true
  has_many :server_attributes, :dependent => :destroy, :autosave => true
  has_one :lparstat, :dependent => :destroy, :autosave => true
  has_many :wwpns, :autosave => true
  has_many :san_infras, :through => :wwpns
  belongs_to :hardware
  belongs_to :operating_system_type
  belongs_to :operating_system
  belongs_to :customer
  has_many :activities, as: :trackable, :autosave => true, :dependent => :destroy

  attr_accessible  :hostname, :os_type, :os_version


  # validations
  validates_presence_of :customer_id, :hostname

  validates :hostname, uniqueness: { scope: :customer_id  }

  has_paper_trail :class_name => 'ServerVersion', :ignore => [:run_date]

  # List of attributes we don't want in ransack search
  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "hardware_id", "operating_system_id", "operating_system_type_id", "customer_id", "id"]

  # Remove UNRANSACKABLE_ATTRIBUTES from ransack search
  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

  # This return a server count grouped by customer
  # * *Returns* :
  #   - returns a server count by customer
  def self.customers_data
      group(:customer).order("count_hostname DESC").count(:hostname)
  end

  # This return a server count grouped by operating system version
  # * *Returns* :
  #   - returns a server count by system version
  def self.releases_data
    group(:operating_system).order("count_hostname DESC").count(:hostname)
  end

  # This method return every servers not found in both fabrics
  # * *Arguments*    :
  #  - *fabric1* -> first fabric which server belongs
  #  - *fabric2* -> second fabric which server should belongs
  # * *Returns* :
  #   - returns every servers belonging to fabric1 but not to fabric2
  def self.not_in_both_fabrics(fabric1, fabric2)
    joins(:san_infras).where('fabric = ?', fabric1) - joins(:san_infras).where('fabric = ?', fabric2)
  end

  def add_or_update_attribute(name, value)
    attr = server_attributes.find_or_create_by_name(name)
    attr.update_attributes(output: value, category: "inv")
    attr.activities.find_or_create_by_action("update").touch
  end

  def add_or_update_vg(name, size, free)
    vg = volume_groups.find_or_create_by_name(name)
    vg.update_attributes(vg_size: size, free_size: free)
    vg.activities.find_or_create_by_action("update").touch
  end

  def add_or_update_fs(mount_point, device, size, free)
    fs = file_systems.find_or_create_by_mount_point(mount_point)
    fs.update_attributes(size: size, device: device, free: free)
    fs.activities.find_or_create_by_action("update").touch
  end

  def add_or_update_secfix(name, rhsa, category, severity)
    fix = linux_security_fixes.find_or_create_by_name(name)
    fix.update_attributes(rhsa: rhsa, category: category, severity: severity)
    fix.activities.find_or_create_by_action("update").touch
  end

  def add_or_update_linux_port(name, brand, model, card_type, speed, slot, driver, wwpn, firmware)
    wwn = Wwpn.find_by_wwpn(wwpn)
    if wwn.nil?
      wwn=wwpns.create!(wwpn: wwpn)
    end
    unless wwn.server_id == self.id
      wwpns << wwn
    end

    begin
      wwn.linux_port.update_attributes(name: name, brand: brand, card_model: model, card_type: card_type, speed: speed, slot: slot, driver: driver, firmware: firmware)
    rescue
      wwn.create_linux_port(name: name, brand: brand, card_model: model, card_type: card_type, speed: speed, slot: slot, driver: driver, firmware: firmware)
    end
    wwn.activities.find_or_create_by_action("update").touch
  end

  def add_or_update_aix_port(name, wwpn)
    wwn = Wwpn.find_by_wwpn(wwpn)
    if wwn.nil?
      wwn=wwpns.build(wwpn: wwpn)
    else
      unless wwn.server_id == self.id
        wwpns << wwn
      end
    end

    begin
      wwn.aix_port.name=name
    rescue
      wwn.build_aix_port(name: name)
    end
    wwn.activities.find_or_initialize_by_action("update").touch
  end

  def add_or_update_ip_address(address, subnet, mac_address)
    ip = ip_addresses.find_or_create_by_address(address)
    ip.update_attributes(subnet: subnet, mac_address: mac_address)
    ip.activities.find_or_create_by_action("update").touch
  end

  def os_type
    operating_system_type.name
  end

  def os_version
    operating_system.release
  end

  def customer_name
    customer.name
  end
end
