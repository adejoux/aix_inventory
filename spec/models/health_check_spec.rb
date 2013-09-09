require 'spec_helper'

describe HealthCheck do
  it "has a valid factory" do
    FactoryGirl.create(:health_check).should be_valid
  end
  # it "is invalid without a description" do
  #   FactoryGirl.build(:health_check, check: nil).should_not be_valid
  # end
  # it "is invalid without a status" do
  #   FactoryGirl.build(:health_check, check: nil).should_not be_valid
  # end
end
