class VolumeGroup < ActiveRecord::Base
  attr_accessible :free_size, :name, :server_id, :vg_size
  belongs_to :server
end
