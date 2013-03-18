# == Schema Information
#
# Table name: aix_alerts
#
#  id           :integer          not null, primary key
#  alert_type   :string(255)
#  check        :string(255)
#  valid_status :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class AixAlert < ActiveRecord::Base
  attr_accessible :alert_type, :check, :valid_status
  
  validates_presence_of :alert_type, :check, :valid_status
  validates_uniqueness_of :check 
end
