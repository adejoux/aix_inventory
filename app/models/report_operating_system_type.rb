# == Schema Information
#
# Table name: report_operating_system_types
#
#  id                       :integer          not null, primary key
#  report_id                :integer
#  operating_system_type_id :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class ReportOperatingSystemType < ActiveRecord::Base
  belongs_to :report
  belongs_to :operating_system_type
  # attr_accessible :title, :body
end
