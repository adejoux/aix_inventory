# == Schema Information
#
# Table name: aix_ports
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  wwpn_id    :integer
#

# -*- encoding : utf-8 -*-
require 'spec_helper'

describe AixPort do
  it "has a valid factory" do
    FactoryGirl.create(:aix_port).should be_valid
  end
  it "is invalid without a port" do
    FactoryGirl.build(:aix_port, port: nil).should_not be_valid
  end
end
