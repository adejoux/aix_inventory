class LinuxSecurityFix < ActiveRecord::Base
  attr_accessible :category, :name, :rhsa, :severity
  belongs_to :server
  has_many :activities, as: :trackable, :autosave => true
end
