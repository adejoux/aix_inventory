require 'spec_helper'

describe "HealthChecks" do
  describe "GET /health_checks" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get health_checks_path
      response.status.should be(200)
    end
  end
end
