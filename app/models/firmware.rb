# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: firmwares
#
#  id          :integer          not null, primary key
#  model       :string(255)
#  recommended :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Firmware < ActiveRecord::Base
  attr_accessible :model, :recommended

  # validations
  validates_presence_of :model, :recommended
  validates_uniqueness_of :model
end
