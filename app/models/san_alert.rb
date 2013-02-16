class SanAlert < ActiveRecord::Base
  attr_accessible :alert_type, :fabric1, :fabric2
  
  validates_presence_of :alert_type, :fabric1, :fabric2
  validates :fabric1, uniqueness: { scope: :fabric2  }
   
end
