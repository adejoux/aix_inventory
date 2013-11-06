# == Schema Information
#
# Table name: operating_systems
#
#  id                       :integer          not null, primary key
#  release                  :string(255)
#  operating_system_type_id :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class OperatingSystem < ActiveRecord::Base
  belongs_to :operating_system_type
  attr_accessible :release

  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "operating_system_type_id", "id"]
  # Remove UNRANSACKABLE_ATTRIBUTES from ransack search
  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end

end
