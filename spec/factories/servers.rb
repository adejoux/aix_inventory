# -*- encoding : utf-8 -*-
#spec/factories/servers.rb
require 'faker'

FactoryGirl.define do
  factory :server do |f|
    f.hostname "server1"
    f.customer "cust1"
    f.os_version "6.1"
    f.os_type "aix"
    f.run_date "01/01/2013"
  end
end
