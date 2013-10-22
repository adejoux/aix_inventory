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
  include Workflow
  attr_accessible :upload, :import_type
  has_attached_file :upload

  TYPES = %w[server san sod]

  def csv_file_content?
    if upload_content_type.match(/csv/)
      return true
    else
      return false
    end
  end

end
