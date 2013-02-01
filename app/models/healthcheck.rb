# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: healthchecks
#
#  id         :integer          not null, primary key
#  check      :string(255)
#  status     :string(255)
#  server_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Healthcheck < ActiveRecord::Base
  belongs_to :server
  attr_accessible :check, :status
    
  #validations
  validates_presence_of :check, :status
  
  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "id", "server_id"]
  
  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
