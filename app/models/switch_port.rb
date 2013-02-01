# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: switch_ports
#
#  id          :integer          not null, primary key
#  fabric      :string(255)
#  domain      :string(255)
#  port        :string(255)
#  wwpn        :string(255)
#  port_alias  :string(255)
#  aix_port_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SwitchPort < ActiveRecord::Base
  belongs_to :aix_port
  attr_accessible :port_alias, :domain, :fabric, :port, :wwpn, :aix_port_id

  # validations
  validates_presence_of :port, :wwpn, :port_alias, :domain, :fabric
  validates :wwpn, :uniqueness => true

  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "id", "aix_port_id" ]
  
  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
