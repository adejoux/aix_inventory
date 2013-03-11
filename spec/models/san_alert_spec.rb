require 'spec_helper'

describe SanAlert do
  it "has a valid factory" do
    FactoryGirl.create(:san_alert).should be_valid
  end

  it "is invalid without a alert_type" do
    FactoryGirl.build(:san_alert, alert_type: nil).should_not be_valid
  end

  it "is invalid without a fabric1" do
    FactoryGirl.build(:san_alert, fabric1: nil).should_not be_valid
  end
  
  it "is invalid without a fabric2" do
    FactoryGirl.build(:san_alert, fabric2: nil).should_not be_valid
  end
  
  it "does not allow duplicate fabric1 in scope of fabric2" do
    FactoryGirl.create(:san_alert, fabric1: "test", fabric2: "test2" )
    FactoryGirl.build(:san_alert, fabric1: "test", fabric2: "test2" ).should_not be_valid
  end

end
