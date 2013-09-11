class LinuxSecurityFix < ActiveRecord::Base
  attr_accessible :category, :name, :rhsa, :severity
  belongs_to :server
end
