# == Schema Information
#
# Table name: hardwares
#
#  id         :integer          not null, primary key
#  sys_model  :string(255)
#  firmware   :string(255)
#  serial     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Hardware < ActiveRecord::Base
  attr_accessible :firmware, :serial, :sys_model

  has_many :servers
  has_many :lparstats, :through => :servers
  has_many :activities, as: :trackable, :autosave => true

  validates_presence_of :firmware, :serial, :sys_model
  validates_uniqueness_of :serial
  #validates :sys_model, :format => { :with => /-/, :message => "should be like TTTT-MMM"}
end
