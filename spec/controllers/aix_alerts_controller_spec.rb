require 'spec_helper'

describe AixAlertsController do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:aix_alerts]
    user = FactoryGirl.create(:user)
    sign_in user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
    it "assigns all aix_alerts as @aix_alerts" do
      aix_alert = FactoryGirl.create(:aix_alert)
      get :index
      assigns(:aix_alerts).should eq([aix_alert])
    end
  end

  describe "GET 'show'" do
    it "assigns the requested aix_alert to @aix_alert" do
      aix_alert = FactoryGirl.create(:aix_alert)
      get :show, id: aix_alert
      assigns(:aix_alert).should eq(aix_alert)
    end
    it "renders the #show view" do
     get 'show', id: FactoryGirl.create(:aix_alert)
     response.should render_template :show
    end
  end
 

  describe "GET show" do
    it "assigns the requested aix_alert as @aix_alert" do
      aix_alert = FactoryGirl.create(:aix_alert)
      get :show, {:id => aix_alert.to_param}
      assigns(:aix_alert).should eq(aix_alert)
    end
  end

  describe "GET new" do
    it "assigns a new aix_alert as @aix_alert" do
      get :new
      assigns(:aix_alert).should be_a_new(AixAlert)
    end
  end

  describe "GET edit" do
    it "assigns the requested aix_alert as @aix_alert" do
      aix_alert = FactoryGirl.create(:aix_alert)
      get :edit, {:id => aix_alert.to_param}
      assigns(:aix_alert).should eq(aix_alert)
    end
  end
end
