# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: firmwares
#
#  id          :integer          not null, primary key
#  model       :string(255)
#  recommended :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Firmware do
  it "has a valid factory" do
    FactoryGirl.create(:firmware).should be_valid
  end

  it "is invalid without a model" do
    FactoryGirl.build(:firmware, model: nil).should_not be_valid
  end

  it "does not allow duplicate model" do
    FactoryGirl.create(:firmware, model: "9117-MMA" )
    FactoryGirl.build(:firmware, model: "9117-MMA" ).should_not be_valid
  end

  it "is invalid without a recommended field" do
    FactoryGirl.build(:firmware, recommended: nil).should_not be_valid
  end
end
