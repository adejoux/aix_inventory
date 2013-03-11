require 'spec_helper'

describe AixAlert do
  it "has a valid factory" do
    FactoryGirl.create(:aix_alert).should be_valid
  end

  it "is invalid without a alert_type" do
    FactoryGirl.build(:aix_alert, alert_type: nil).should_not be_valid
  end

  it "is invalid without a check" do
    FactoryGirl.build(:aix_alert, check: nil).should_not be_valid
  end
  
  it "is invalid without a valid_status" do
    FactoryGirl.build(:aix_alert, valid_status: nil).should_not be_valid
  end
  
  it "does not allow duplicate check" do
    FactoryGirl.create(:aix_alert, check: "test" )
    FactoryGirl.build(:aix_alert, check: "test" ).should_not be_valid
  end

end
