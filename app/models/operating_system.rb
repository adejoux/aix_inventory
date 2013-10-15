class OperatingSystem < ActiveRecord::Base
  belongs_to :operating_system_type
  attr_accessible :release, :operating_system_type_id
end
