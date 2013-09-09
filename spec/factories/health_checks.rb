# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :health_check do
    name "MyString"
    description "MyText"
    return_code 1
    output "MyText"
    hc_errors "MyText"
    server_id 1
  end
end
