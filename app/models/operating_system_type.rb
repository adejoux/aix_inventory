class OperatingSystemType < ActiveRecord::Base
  attr_accessible :description, :name
  has_one :server
  has_many :operating_systems
end
