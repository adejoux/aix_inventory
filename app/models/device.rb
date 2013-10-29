class Device < ActiveRecord::Base
  belongs_to :server
  attr_accessible :description, :location, :name, :status
end
