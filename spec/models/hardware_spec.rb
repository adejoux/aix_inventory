# == Schema Information
#
# Table name: hardwares
#
#  id         :integer          not null, primary key
#  sys_model  :string(255)
#  firmware   :string(255)
#  serial     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Hardware do
  it "has a valid factory" do
    FactoryGirl.create(:hardware).should be_valid
  end
  it "is invalid without a sys_model" do
    FactoryGirl.build(:hardware, sys_model: nil).should_not be_valid
  end
  it "is invalid without a sys_model format of TTTT-MMM" do
    FactoryGirl.build(:hardware, sys_model: "test").should_not be_valid
  end
  it "is invalid without a serial" do
    FactoryGirl.build(:hardware, serial: nil).should_not be_valid
  end
  it "is invalid without a firmware" do
    FactoryGirl.build(:hardware, firmware: nil).should_not be_valid
  end
end
