class LinuxPort < ActiveRecord::Base
  attr_accessible :brand, :card_type, :driver, :card_model, :name, :slot, :speed
  belongs_to :server
  belongs_to :wwpn
  has_many :activities, as: :trackable, :autosave => true
end
