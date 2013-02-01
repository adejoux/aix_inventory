# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ServersController do
   before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:servers]
    user = FactoryGirl.create(:user)
    sign_in user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "assigns the requested server to @server" do
      server = FactoryGirl.create(:server)
      get :show, id: server
      assigns(:server).should eq(server)
    end
    it "renders the #show view" do
     get 'show', id: FactoryGirl.create(:server)
     response.should render_template :show
    end
  end
end

