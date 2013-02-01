# -*- encoding : utf-8 -*-
require 'spec_helper'

describe HardwaresController do
   before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:hardwares]
      user = FactoryGirl.create(:user)
      sign_in user
    end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
