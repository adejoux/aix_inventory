# -*- encoding : utf-8 -*-
require 'spec_helper'

describe FirmwaresController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:firmwares]
    user = FactoryGirl.create(:user)
    sign_in user
  end

  # This should return the minimal set of attributes required to create a valid
  # Firmware. As you add validations to Firmware, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "model" => "MyString", "recommended" => "version" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # FirmwaresController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all firmwares as @firmwares" do
      firmware = Firmware.create! valid_attributes
      get :index, {}
      assigns(:firmwares).should eq([firmware])
    end
  end

  describe "GET show" do
    it "assigns the requested firmware as @firmware" do
      firmware = Firmware.create! valid_attributes
      get :show, {:id => firmware.to_param}
      assigns(:firmware).should eq(firmware)
    end
  end

  describe "GET new" do
    it "assigns a new firmware as @firmware" do
      get :new, {}
      assigns(:firmware).should be_a_new(Firmware)
    end
  end

  describe "GET edit" do
    it "assigns the requested firmware as @firmware" do
      firmware = Firmware.create! valid_attributes
      get :edit, {:id => firmware.to_param}
      assigns(:firmware).should eq(firmware)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Firmware" do
        expect {
          post :create, {:firmware => valid_attributes}
        }.to change(Firmware, :count).by(1)
      end

      it "assigns a newly created firmware as @firmware" do
        post :create, {:firmware => valid_attributes}
        assigns(:firmware).should be_a(Firmware)
        assigns(:firmware).should be_persisted
      end

      it "redirects to the created firmware" do
        post :create, {:firmware => valid_attributes}
        response.should redirect_to(Firmware.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved firmware as @firmware" do
        # Trigger the behavior that occurs when invalid params are submitted
        Firmware.any_instance.stub(:save).and_return(false)
        post :create, {:firmware => { "model" => "invalid value" }}
        assigns(:firmware).should be_a_new(Firmware)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Firmware.any_instance.stub(:save).and_return(false)
        post :create, {:firmware => { "model" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested firmware" do
        firmware = Firmware.create! valid_attributes
        # Assuming there are no other firmwares in the database, this
        # specifies that the Firmware created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Firmware.any_instance.should_receive(:update_attributes).with({ "model" => "MyString" })
        put :update, {:id => firmware.to_param, :firmware => { "model" => "MyString" }}
      end

      it "assigns the requested firmware as @firmware" do
        firmware = Firmware.create! valid_attributes
        put :update, {:id => firmware.to_param, :firmware => valid_attributes}
        assigns(:firmware).should eq(firmware)
      end

      it "redirects to the firmware" do
        firmware = Firmware.create! valid_attributes
        put :update, {:id => firmware.to_param, :firmware => valid_attributes}
        response.should redirect_to(firmware)
      end
    end

    describe "with invalid params" do
      it "assigns the firmware as @firmware" do
        firmware = Firmware.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Firmware.any_instance.stub(:save).and_return(false)
        put :update, {:id => firmware.to_param, :firmware => { "model" => "invalid value" }}
        assigns(:firmware).should eq(firmware)
      end

      it "re-renders the 'edit' template" do
        firmware = Firmware.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Firmware.any_instance.stub(:save).and_return(false)
        put :update, {:id => firmware.to_param, :firmware => { "model" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested firmware" do
      firmware = Firmware.create! valid_attributes
      expect {
        delete :destroy, {:id => firmware.to_param}
      }.to change(Firmware, :count).by(-1)
    end

    it "redirects to the firmwares list" do
      firmware = Firmware.create! valid_attributes
      delete :destroy, {:id => firmware.to_param}
      response.should redirect_to(firmwares_url)
    end
  end

end
