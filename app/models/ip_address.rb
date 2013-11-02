# == Schema Information
#
# Table name: ip_addresses
#
#  id          :integer          not null, primary key
#  address     :string(255)
#  subnet      :string(255)
#  mac_address :string(255)
#  server_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class IpAddress < ActiveRecord::Base
  attr_accessible :address, :mac_address, :server_id, :subnet
  belongs_to :server
  has_many :activities, as: :trackable, :autosave => true, :dependent => :destroy
end
