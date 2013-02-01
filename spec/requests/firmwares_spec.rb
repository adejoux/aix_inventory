# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Firmwares" do
  before(:each) do
    @user ||= FactoryGirl.create :user
    post_via_redirect user_session_path, 'user[username]' => @user.username, 'user[password]' => @user.password
  end

  describe "GET /firmwares" do
    it "return a success code" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get firmwares_path
      response.status.should be(200)
    end
  end
end
