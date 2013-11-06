# == Schema Information
#
# Table name: operating_system_types
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class OperatingSystemType < ActiveRecord::Base
  attr_accessible :description, :name
  has_one :server
  has_many :operating_systems

  validates_uniqueness_of :name

  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "description", "id"]
  # Remove UNRANSACKABLE_ATTRIBUTES from ransack search
  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
