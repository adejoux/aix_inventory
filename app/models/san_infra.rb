# == Schema Information
#
# Table name: san_infras
#
#  id         :integer          not null, primary key
#  infra      :string(20)
#  fabric     :string(20)
#  switch     :string(20)
#  speed      :string(20)
#  status     :string(20)
#  portname   :string(20)
#  mode       :string(20)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SanInfra < ActiveRecord::Base
  attr_accessible :fabric, :infra, :mode, :port, :portname, :speed, :status, :switch

  validates_presence_of :fabric, :infra, :mode, :port, :portname, :speed, :status, :switch
  validates :port, uniqueness: { scope: :switch  }
  has_many :wwpn, :autosave => true
  has_many :activities, as: :trackable, :autosave => true, :dependent => :destroy

  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "id"]

  def self.ransackable_attributes auth_object = nil
    (column_names - UNRANSACKABLE_ATTRIBUTES) + _ransackers.keys
  end
end
