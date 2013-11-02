# == Schema Information
#
# Table name: linux_ports
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  brand      :string(255)
#  card_model :string(255)
#  card_type  :string(255)
#  speed      :string(255)
#  slot       :string(255)
#  driver     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  wwpn_id    :integer
#  firmware   :string(255)
#

class LinuxPort < ActiveRecord::Base
  attr_accessible :brand, :card_type, :driver, :card_model, :name, :slot, :speed, :firmware
  belongs_to :server
  belongs_to :wwpn
  has_many :activities, as: :trackable, :autosave => true, :dependent => :destroy

  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "id"]

end
