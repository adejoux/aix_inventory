# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: healthchecks
#
#  id         :integer          not null, primary key
#  check      :string(255)
#  status     :string(255)
#  server_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Healthcheck do
  it "has a valid factory" do
    FactoryGirl.create(:healthcheck).should be_valid
  end
  it "is invalid without a check" do
    FactoryGirl.build(:healthcheck, check: nil).should_not be_valid
  end
  it "is invalid without a status" do
    FactoryGirl.build(:healthcheck, check: nil).should_not be_valid
  end  
end
