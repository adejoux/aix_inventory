# -*- encoding : utf-8 -*-
require 'spec_helper'

describe SwitchPortsController do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:switch_ports]
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
    it "assigns the requested switch port to @switch_port" do
      switch_port = FactoryGirl.create(:switch_port)
      get :show, id: switch_port
      assigns(:switch_port).should eq(switch_port)
    end
    it "renders the #show view" do
     get 'show', id: FactoryGirl.create(:switch_port)
     response.should render_template :show
    end
  end
end
