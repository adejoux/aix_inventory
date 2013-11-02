# == Schema Information
#
# Table name: aix_ports
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  wwpn_id    :integer
#

# -*- encoding : utf-8 -*-
class AixPort < ActiveRecord::Base
  belongs_to :wwpn
  attr_accessible :name
  has_many :activities, as: :trackable, :autosave => true, :dependent => :destroy


  # validations
  validates_presence_of :name
  #validates_uniqueness_of :name

  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "id"]

  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
