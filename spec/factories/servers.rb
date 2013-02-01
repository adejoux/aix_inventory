# -*- encoding : utf-8 -*-
#spec/factories/servers.rb
require 'faker'

FactoryGirl.define do
  factory :server do |f|
    f.hostname "server1"
    f.customer "cust1" 
    f.os_version "6.1" 
    f.os_type "aix" 
    f.sys_model "mma"
    f.sys_serial "012345"
    f.sys_fwversion "fw01"
    f.global_image "no global"
    f.install_date "01/01/2013"
  end
end
