# == Schema Information
#
# Table name: wwpns
#
#  id           :integer          not null, primary key
#  wwpn         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  server_id    :integer
#  san_infra_id :integer
#

require 'spec_helper'

describe Wwpn do
  pending "add some examples to (or delete) #{__FILE__}"
end
