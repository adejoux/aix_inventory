# == Schema Information
#
# Table name: san_infras
#
#  id         :integer          not null, primary key
#  infra      :string(20)
#  fabric     :string(20)
#  switch     :string(20)
#  speed      :string(20)
#  status     :string(20)
#  portname   :string(20)
#  mode       :string(20)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe SanInfra do
  pending "add some examples to (or delete) #{__FILE__}"
end
