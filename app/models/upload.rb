# == Schema Information
#
# Table name: uploads
#
#  id                  :integer          not null, primary key
#  upload_file_name    :string(255)
#  upload_content_type :string(255)
#  upload_file_size    :integer
#  upload_updated_at   :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  import_type         :string(255)
#  workflow_state      :string(255)
#

class Upload < ActiveRecord::Base
  attr_accessible :upload, :import_type
  has_attached_file :upload, :path => ":rails_root/import/new/:import_type/:filename"

  TYPES = %w[server san]
end
