# == Schema Information
#
# Table name: import_logs
#
#  id            :integer          not null, primary key
#  upload_id     :integer
#  result        :string(255)
#  content       :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  success_count :integer
#  error_count   :integer
#

class ImportLog < ActiveRecord::Base
  attr_accessible :content, :result
end
