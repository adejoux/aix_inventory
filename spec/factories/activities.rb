# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    action "MyString"
    trackable nil
    trackable_type "MyString"
  end
end
