# == Schema Information
#
# Table name: health_checks
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  return_code :integer
#  output      :text
#  hc_errors   :text
#  server_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  info        :text
#

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
