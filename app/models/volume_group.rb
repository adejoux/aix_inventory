# == Schema Information
#
# Table name: volume_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  vg_size    :string(255)
#  free_size  :string(255)
#  server_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class VolumeGroup < ActiveRecord::Base
  attr_accessible :free_size, :name, :vg_size
  belongs_to :server
  has_many :activities, as: :trackable, :autosave => true, :dependent => :destroy
end
