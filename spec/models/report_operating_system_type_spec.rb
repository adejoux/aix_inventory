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

require 'spec_helper'

describe ReportOperatingSystemType do
  pending "add some examples to (or delete) #{__FILE__}"
end
