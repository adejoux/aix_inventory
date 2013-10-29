class FileSystem < ActiveRecord::Base
  attr_accessible :free, :mount_point, :device, :size
  belongs_to :server
  has_many :activities, as: :trackable, :autosave => true, :dependent => :destroy
  has_paper_trail :class_name => 'FileSystemVersion', :only => [:free, :mount_point, :device, :size ]
end
