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

require 'spec_helper'

describe IpAddress do
  pending "add some examples to (or delete) #{__FILE__}"
end
