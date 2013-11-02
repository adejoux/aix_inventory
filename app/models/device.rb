# == Schema Information
#
# Table name: devices
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  status      :string(255)
#  location    :string(255)
#  description :string(255)
#  server_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Device < ActiveRecord::Base
  belongs_to :server
  attr_accessible :description, :location, :name, :status
end
