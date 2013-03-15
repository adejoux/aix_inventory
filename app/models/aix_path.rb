# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: aix_paths
#
#  id         :integer          not null, primary key
#  adapter    :string(255)
#  state      :string(255)
#  mode       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  server_id  :integer
#  path       :integer
#

class AixPath < ActiveRecord::Base
  belongs_to :server
  attr_accessible :path, :adapter, :mode, :state
  
  #validations
  validates_presence_of :adapter, :mode, :state, :path
  
  
  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "id", "server_id"]
  
  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

  def self.find_by_server_and_adapter(server_id, adapter)
    where('"server_id" = ? and "adapter" = ?', server_id, adapter).first
  end
end
