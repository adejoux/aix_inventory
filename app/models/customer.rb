class Customer < ActiveRecord::Base
  attr_accessible :description, :name
  has_one :server

  validates_uniqueness_of :name
  validates_presence_of :name
end
