# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wwpn do
    server_id 1
    san_infra_id 1
    sod_infra_id 1
    wwpn "MyString"
  end
end
