class LinuxPort < ActiveRecord::Base
  attr_accessible :brand, :card_type, :driver, :card_model, :name, :slot, :speed, :firmware
  belongs_to :server
  belongs_to :wwpn
  has_many :activities, as: :trackable, :autosave => true, :dependent => :destroy

  UNRANSACKABLE_ATTRIBUTES = ["created_at", "updated_at", "id"]

end
