# == Schema Information
#
# Table name: import_reports
#
#  id            :integer          not null, primary key
#  filename      :string(255)
#  result        :string(255)
#  output        :text
#  success_count :integer
#  error_count   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe ImportReport do
  pending "add some examples to (or delete) #{__FILE__}"
end
