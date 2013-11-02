# == Schema Information
#
# Table name: volume_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  vg_size    :string(255)
#  free_size  :string(255)
#  server_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe VolumeGroup do
  pending "add some examples to (or delete) #{__FILE__}"
end
