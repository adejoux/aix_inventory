# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :healthcheck do
    check "sshd"
    status "ok"
    server_id 1
  end
end
