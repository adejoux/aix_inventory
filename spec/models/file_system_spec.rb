# == Schema Information
#
# Table name: file_systems
#
#  id          :integer          not null, primary key
#  mount_point :string(255)
#  size        :string(255)
#  free        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  server_id   :integer
#  device      :string(255)
#

require 'spec_helper'

describe FileSystem do
  pending "add some examples to (or delete) #{__FILE__}"
end
