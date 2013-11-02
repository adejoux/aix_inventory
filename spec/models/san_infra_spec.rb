# == Schema Information
#
# Table name: san_infras
#
#  id         :integer          not null, primary key
#  infra      :string(15)
#  fabric     :string(15)
#  switch     :string(30)
#  port       :string(10)
#  speed      :string(5)
#  status     :string(15)
#  portname   :string(30)
#  mode       :string(15)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe SanInfra do
  pending "add some examples to (or delete) #{__FILE__}"
end
