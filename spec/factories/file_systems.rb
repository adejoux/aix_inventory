# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :file_system do
    mount_point "MyString"
    size "MyString"
    free "MyString"
  end
end
