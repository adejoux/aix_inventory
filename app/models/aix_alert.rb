class AixAlert < ActiveRecord::Base
  attr_accessible :alert_type, :check, :valid_status
  
  validates_presence_of :alert_type, :check, :valid_status
  validates_uniqueness_of :check 
end
