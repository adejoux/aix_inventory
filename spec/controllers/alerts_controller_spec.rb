require 'spec_helper'

describe AlertsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:alerts]
    user = FactoryGirl.create(:user)
    sign_in user
  end
  describe "GET 'alerts_san'" do
    it "returns http success" do
      get 'san_alerts'
      response.should be_success
    end
  end

  describe "GET 'alerts_aix'" do
    it "returns http success" do
      get 'aix_alerts'
      response.should be_success
    end
  end
end
