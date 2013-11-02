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

class LinuxSecurityFix < ActiveRecord::Base
  attr_accessible :category, :name, :rhsa, :severity
  belongs_to :server
  has_many :activities, as: :trackable, :autosave => true, :dependent => :destroy
end
