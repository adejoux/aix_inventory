# == Schema Information
#
# Table name: san_alerts
#
#  id         :integer          not null, primary key
#  alert_type :string(255)
#  fabric1    :string(255)
#  fabric2    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SanAlert < ActiveRecord::Base
  attr_accessible :alert_type, :fabric1, :fabric2
  
  validates_presence_of :alert_type, :fabric1, :fabric2
  validates :fabric1, uniqueness: { scope: :fabric2  }
   
end
