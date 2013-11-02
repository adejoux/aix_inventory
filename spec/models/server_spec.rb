# == Schema Information
#
# Table name: servers
#
#  id                       :integer          not null, primary key
#  hostname                 :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  run_date                 :date
#  hardware_id              :integer
#  customer_id              :integer
#  operating_system_type_id :integer
#  operating_system_id      :integer
#

# -*- encoding : utf-8 -*-
# spec/models/server_spec.rb
require 'spec_helper'

describe Server do
  it "has a valid factory" do
    FactoryGirl.create(:server).should be_valid
  end
  it "is invalid without a hostname" do
    FactoryGirl.build(:server, hostname: nil).should_not be_valid
  end
  it "is invalid without a customer" do
    FactoryGirl.build(:server, customer: nil).should_not be_valid
  end
  it "is invalid without a os version" do
    FactoryGirl.build(:server, os_version: nil).should_not be_valid
  end
  it "is invalid without a os type" do
    FactoryGirl.build(:server, os_type: nil).should_not be_valid
  end
  it "does not allow duplicate hostname per customer" do
    FactoryGirl.create(:server, hostname: "server1" )
    FactoryGirl.build(:server, hostname: "server1" ).should_not be_valid
  end
  it "allow same hostname on different customers" do
    FactoryGirl.create(:server, hostname: "server1", customer: "cust1")
    FactoryGirl.create(:server, hostname: "server1", customer: "cust2").should be_valid
  end
  
  it "can have software" do
    server=FactoryGirl.create(:server)
    server.softwares.create(:name => "test1", :version => "1" ).should be_valid
  end
  it "can have fibre adapter" do
    server=FactoryGirl.create(:server)
    server.aix_ports.create( :port => "fcs1").should be_valid
  end
  it "can have san paths" do
    server=FactoryGirl.create(:server)
    server.aix_paths.create( :path => "0", :adapter => "fcs1", :state => "normal", :mode => "active").should be_valid
  end
  it "can have healthcheck" do
    server=FactoryGirl.create(:server)
    server.healthchecks.create(:check => "test1", :status => "1" ).should be_valid
  end
end
