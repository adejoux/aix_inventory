# == Schema Information
#
# Table name: san_infras
#
#  id         :integer          not null, primary key
#  infra      :string(15)
#  fabric     :string(15)
#  switch     :string(30)
#  port       :string(10)
#  speed      :string(5)
#  status     :string(15)
#  portname   :string(30)
#  mode       :string(15)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SanInfra < ActiveRecord::Base
  attr_accessible :fabric, :infra, :mode, :port, :portname, :speed, :status, :switch

  validates_presence_of :fabric, :infra, :mode, :port, :portname, :speed, :status, :switch
  validates :port, uniqueness: { scope: :switch  }
  has_many :wwpns, :autosave => true
  has_many :activities, as: :trackable, :autosave => true, :dependent => :destroy

  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "id"]

  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
