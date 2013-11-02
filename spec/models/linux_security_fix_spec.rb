# == Schema Information
#
# Table name: linux_security_fixes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  severity   :string(255)
#  rhsa       :string(255)
#  category   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  server_id  :integer
#

require 'spec_helper'

describe LinuxSecurityFix do
  pending "add some examples to (or delete) #{__FILE__}"
end
