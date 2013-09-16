# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :import_report do
    filename "MyString"
    result "MyString"
    output "MyText"
    success_count 1
    error_count 1
  end
end
