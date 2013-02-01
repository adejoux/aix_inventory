# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: aix_paths
#
#  id         :integer          not null, primary key
#  adapter    :string(255)
#  state      :string(255)
#  mode       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  server_id  :integer
#  path       :integer
#

require 'spec_helper'

describe AixPath do
  it "has a valid factory" do
    FactoryGirl.create(:aix_path).should be_valid
  end
  it "is invalid without a adapter" do
    FactoryGirl.build(:aix_path, adapter: nil).should_not be_valid
  end
  it "is invalid without a state" do
    FactoryGirl.build(:aix_path, state: nil).should_not be_valid
  end
  it "is invalid without a mode" do
    FactoryGirl.build(:aix_path, mode: nil).should_not be_valid
  end
end
