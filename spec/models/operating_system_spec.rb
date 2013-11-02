# == Schema Information
#
# Table name: operating_systems
#
#  id                       :integer          not null, primary key
#  release                  :string(255)
#  operating_system_type_id :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

require 'spec_helper'

describe OperatingSystem do
  pending "add some examples to (or delete) #{__FILE__}"
end
