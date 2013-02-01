# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Servers" do
  before(:each) do
    @user ||= FactoryGirl.create :user
    server = FactoryGirl.create(:server)
    post_via_redirect user_session_path, 'user[username]' => @user.username, 'user[password]' => @user.password
  end

  describe "GET /servers" do
    it "returns a valid json response" do
      get servers_path, :format => :json
      response.should be_success
      body = JSON.parse(response.body)
      body.should include('aaData')
    end
  end
end
