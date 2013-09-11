# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :volume_group do
    name "MyString"
    vg_size "MyString"
    free_size "MyString"
    server_id 1
  end
end
