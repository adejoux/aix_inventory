# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :software_deployment do
    software_id 1
    server_id 1
  end
end
