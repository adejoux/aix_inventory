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
