class FileSystem < ActiveRecord::Base
  attr_accessible :free, :mount_point, :size
  belongs_to :server
end
