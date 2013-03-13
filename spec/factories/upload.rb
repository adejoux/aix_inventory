# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :upload, :class => 'Upload' do
    upload_file_name "MyString"
    upload_content_type "MyString"
    upload_file_size 1
    upload_updated_at "MyString"
  end
end
