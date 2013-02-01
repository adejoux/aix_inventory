# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :aix_path do
    path "0"
    adapter "fcs1"
    state "normal"
    mode "active"
  end
end
