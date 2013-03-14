# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :import_log do
    upload_id 1
    result "MyString"
    content "MyText"
  end
end
