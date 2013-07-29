# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Lparstats" do
  before(:each) do
    @user ||= FactoryGirl.create :user
    lparstat = FactoryGirl.create(:lparstat)
    post_via_redirect user_session_path, 'user[username]' => @user.username, 'user[password]' => @user.password
  end

  describe "GET /lparstats" do
    it "returns a valid json response" do
      get lparstats_path, :format => :json
      response.should be_success
      body = JSON.parse(response.body)
      body.should include('aaData')
    end
  end
end
