# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ip_address do
    address "MyString"
    subnet "MyString"
    mac_address "MyString"
    server_id 1
  end
end
