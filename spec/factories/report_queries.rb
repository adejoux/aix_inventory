# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report_query do
    association_type "MyString"
    select_attribute "MyString"
    report_id "MyString"
  end
end
