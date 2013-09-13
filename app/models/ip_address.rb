class IpAddress < ActiveRecord::Base
  attr_accessible :address, :mac_address, :server_id, :subnet
  belongs_to :server
end
