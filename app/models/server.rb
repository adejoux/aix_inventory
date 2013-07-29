# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: servers
#
#  id            :integer          not null, primary key
#  customer      :string(255)
#  hostname      :string(255)
#  os_type       :string(255)
#  os_version    :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  sys_fwversion :string(255)
#  sys_serial    :string(255)
#  sys_model     :string(255)
#  global_image  :string(255)
#  install_date  :string(255)
#  run_date      :date
#  nim           :string(255)
#

class Server < ActiveRecord::Base
  has_many :aix_ports, :dependent => :destroy, :autosave => true
  has_many :aix_paths, :dependent => :destroy, :autosave => true
  has_many :healthchecks, :dependent => :destroy, :autosave => true
  has_many :software_deployments
  has_one :lparstat
  has_many :softwares, :through => :software_deployments
  has_many :wwpns, :through => :aix_ports
  has_many :san_infras, :through => :wwpns
  accepts_nested_attributes_for :softwares
  accepts_nested_attributes_for :wwpns

  belongs_to :hardware
  accepts_nested_attributes_for :hardware

  attr_accessible :customer, :hostname, :os_type, :os_version

  # validations
  validates_presence_of :customer, :hostname, :os_type, :os_version

  validates :hostname, uniqueness: { scope: :customer  }

  has_paper_trail :class_name => 'ServerVersion', :ignore => [:run_date]

  # List of attributes we don't want in ransack search
  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "id"]

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
    group(:os_version).where(:os_type => "AIX").order("count_hostname DESC").count(:hostname)
  end

  # This return a server count grouped by hardware model
  # * *Returns* :
  #   - returns a server count by hardware version
  def self.sys_models_data
    select("sys_model, count(distinct sys_serial) as count_sys_serial").group(:sys_model).order("count_sys_serial DESC")
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

  # This method return every servers with invalid healthcheck status
  # * *Args*    :
  #  - *check* -> healthcheck service to check
  #  - *status* -> OK status for the helathcheck service
  # * *Returns* :
  #   - returns every servers where healthcheck status is not equals to *status*
  def self.retrieve_aix_invalid_status(check,status)
    joins(:healthchecks).where('healthchecks.check = ?', check)
      .where('healthchecks.status != ?', status)
      .select('servers.customer, servers.hostname, healthchecks.check as healthcheck, healthchecks.status as status')
  end

  # This method provides a find method on servers attributes
  # * *Args*    :
  #  - *search* -> search criteria
  # * *Returns* :
  #   - returns every servers where healthcheck status is not equals to *status*
  def self.aix_alerts_search(search)
    joins(:healthchecks).where('servers.customer like :search or servers.hostname like :search or healthchecks.check like :search or healthchecks.status like :search ',
      search: search)
  end
end
