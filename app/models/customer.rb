# == Schema Information
#
# Table name: customers
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Customer < ActiveRecord::Base
  attr_accessible :description, :name
  has_one :server

  validates_uniqueness_of :name
  validates_presence_of :name

  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "description", "id"]
  # Remove UNRANSACKABLE_ATTRIBUTES from ransack search
  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
