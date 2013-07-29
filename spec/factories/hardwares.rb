# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hardware do
    sys_model "9034-980"
    firmware "MyString"
    serial "MyString"
    server_id 1
  end
end
