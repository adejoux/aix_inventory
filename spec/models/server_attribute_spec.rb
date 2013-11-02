# == Schema Information
#
# Table name: server_attributes
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  category    :string(255)
#  description :text
#  output      :text
#  conf_errors :text
#  return_code :integer
#  server_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe ServerAttribute do
  pending "add some examples to (or delete) #{__FILE__}"
end
