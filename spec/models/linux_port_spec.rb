# == Schema Information
#
# Table name: linux_ports
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  brand      :string(255)
#  card_model :string(255)
#  card_type  :string(255)
#  speed      :string(255)
#  slot       :string(255)
#  driver     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  wwpn_id    :integer
#  firmware   :string(255)
#

require 'spec_helper'

describe LinuxPort do
  pending "add some examples to (or delete) #{__FILE__}"
end
