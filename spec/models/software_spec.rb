# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: softwares
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  version    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Software do
  it "has a valid factory" do
    FactoryGirl.create(:software).should be_valid
  end
  it "is invalid without a name" do
    FactoryGirl.build(:software, name: nil).should_not be_valid
  end
  it "is invalid without a version" do
    FactoryGirl.build(:software, version: nil).should_not be_valid
  end
  it "does not allow duplicate name and version" do
    FactoryGirl.create(:software, name: "soft1", version: "1.0" )
    FactoryGirl.build(:software, name: "soft1",  version: "1.0" ).should_not be_valid
  end
end
