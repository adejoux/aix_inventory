require 'spec_helper'

describe "SanAlerts" do
  before(:each) do
    @user ||= FactoryGirl.create :user
    server = FactoryGirl.create(:san_alert)
    post_via_redirect user_session_path, 'user[username]' => @user.username, 'user[password]' => @user.password
  end
  describe "GET /san_alerts" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get san_alerts_path
      response.status.should be(200)
    end
  end
end
