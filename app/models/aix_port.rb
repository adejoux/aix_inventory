# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: aix_ports
#
#  id         :integer          not null, primary key
#  port       :string(255)
#  wwpn       :string(255)
#  server_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AixPort < ActiveRecord::Base
  belongs_to :server
  has_one :switch_port
  attr_accessible :port, :wwpn
  
  # validations
  validates_presence_of :port, :wwpn
  validates :wwpn, :uniqueness => true
  
  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "id", "server_id"]
  
  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
