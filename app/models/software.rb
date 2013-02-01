# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: softwares
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  version    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Software < ActiveRecord::Base
  attr_accessible :name, :server_id, :version
  has_many :software_deployments
  has_many :servers, :through => :software_deployments
  
  # validations
  validates_presence_of :name, :version
  validates :name, uniqueness: { scope: :version  }
  
end
