# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: software_deployments
#
#  id          :integer          not null, primary key
#  software_id :integer
#  server_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SoftwareDeployment < ActiveRecord::Base
  attr_accessible :server_id, :software_id
  
  belongs_to :server
  belongs_to :software
end
