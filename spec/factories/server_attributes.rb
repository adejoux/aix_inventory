# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :server_attribute do
    name "MyString"
    category "MyString"
    description "MyText"
    output "MyText"
    conf_errors "MyText"
    return_code 1
    server_id 1
  end
end
