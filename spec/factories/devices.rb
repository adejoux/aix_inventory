# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :device do
    name "MyString"
    status "MyString"
    location "MyString"
    description "MyString"
    server nil
  end
end
