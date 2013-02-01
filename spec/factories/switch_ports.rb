# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :switch_port do
    fabric "1MyString"
    domain "2MyString"
    port "3MyString"
    wwpn "4MyString"
    port_alias "5MyString"
    aix_port_id 1
  end
end
