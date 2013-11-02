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

require 'spec_helper'

describe Upload do
  pending "add some examples to (or delete) #{__FILE__}"
end
