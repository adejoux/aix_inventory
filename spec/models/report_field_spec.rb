# == Schema Information
#
# Table name: report_fields
#
#  id               :integer          not null, primary key
#  association_type :string(255)
#  select_attribute :string(255)
#  report_id        :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe ReportField do
  pending "add some examples to (or delete) #{__FILE__}"
end
