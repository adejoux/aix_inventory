class FileSystem < ActiveRecord::Base
  attr_accessible :free, :mount_point, :size
  belongs_to :server
  has_many :activities, as: :trackable, :autosave => true
end
