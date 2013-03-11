# -*- encoding : utf-8 -*-
require 'spec_helper'

describe StatisticsController do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:statistics]
    user = FactoryGirl.create(:user)
    sign_in user
  end

  describe "GET 'general'" do
    it "returns http success" do
      get 'general'
      response.should be_success
    end
  end
  describe "GET 'customer'" do
    it "returns http success" do
      get 'customer'
      response.should be_success
    end
  end
end
