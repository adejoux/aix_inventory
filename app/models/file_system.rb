# == Schema Information
#
# Table name: file_systems
#
#  id          :integer          not null, primary key
#  mount_point :string(255)
#  size        :string(255)
#  free        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  server_id   :integer
#  device      :string(255)
#

class FileSystem < ActiveRecord::Base
  attr_accessible :free, :mount_point, :device, :size
  belongs_to :server
  has_many :activities, as: :trackable, :autosave => true, :dependent => :destroy
  has_paper_trail :class_name => 'FileSystemVersion', :only => [:free, :mount_point, :device, :size ]

  validates_presence_of :server_id
end
