require 'spec_helper'

describe SanAlertsController do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:san_alerts]
    user = FactoryGirl.create(:user)
    sign_in user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
    it "assigns all san_alerts as @san_alerts" do
      san_alert = FactoryGirl.create(:san_alert)
      get :index
      assigns(:san_alerts).should eq([san_alert])
    end
  end

  describe "GET 'show'" do
    it "assigns the requested san_alert to @san_alert" do
      san_alert = FactoryGirl.create(:san_alert)
      get :show, id: san_alert
      assigns(:san_alert).should eq(san_alert)
    end
    it "renders the #show view" do
     get 'show', id: FactoryGirl.create(:san_alert)
     response.should render_template :show
    end
  end
 

  describe "GET show" do
    it "assigns the requested san_alert as @san_alert" do
      san_alert = FactoryGirl.create(:san_alert)
      get :show, {:id => san_alert.to_param}
      assigns(:san_alert).should eq(san_alert)
    end
  end

  describe "GET new" do
    it "assigns a new san_alert as @san_alert" do
      get :new
      assigns(:san_alert).should be_a_new(SanAlert)
    end
  end

  describe "GET edit" do
    it "assigns the requested san_alert as @san_alert" do
      san_alert = FactoryGirl.create(:san_alert)
      get :edit, {:id => san_alert.to_param}
      assigns(:san_alert).should eq(san_alert)
    end
  end
end
