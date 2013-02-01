# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |f|
    f.username "test"
    f.email "test@testland.com"
    f.password "password"
    f.role "admin"
    f.approved true
  end
end
