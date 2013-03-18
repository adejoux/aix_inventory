class Wwpn < ActiveRecord::Base
  attr_accessible :san_infra_id, :server_id, :sod_infra_id, :wwpn
  validates_uniqueness_of :wwpn
end
