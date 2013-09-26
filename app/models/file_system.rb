class FileSystem < ActiveRecord::Base
  attr_accessible :free, :mount_point, :device, :size
  belongs_to :server
  has_many :activities, as: :trackable, :autosave => true, :dependent => :destroy
end
