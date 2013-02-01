# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: switch_ports
#
#  id          :integer          not null, primary key
#  fabric      :string(255)
#  domain      :string(255)
#  port        :string(255)
#  wwpn        :string(255)
#  port_alias  :string(255)
#  aix_port_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe SwitchPort do
 it "has a valid factory" do
    FactoryGirl.create(:switch_port).should be_valid
  end
  it "is invalid without a wwpn" do
    FactoryGirl.build(:switch_port, wwpn: nil).should_not be_valid
  end
  it "is invalid without a port" do
    FactoryGirl.build(:switch_port, port: nil).should_not be_valid
  end
  it "is invalid without a fabric" do
    FactoryGirl.build(:switch_port, fabric: nil).should_not be_valid
  end
  it "is invalid without a domain" do
    FactoryGirl.build(:switch_port, domain: nil).should_not be_valid
  end

  it "is invalid without a port alias" do
    FactoryGirl.build(:switch_port, port_alias: nil).should_not be_valid
  end
  it "does not allow duplicate wwpn" do
    FactoryGirl.create(:switch_port, wwpn: "0000000C99C0ACA" )
    FactoryGirl.build(:switch_port, wwpn: "0000000C99C0ACA" ).should_not be_valid
  end
end
