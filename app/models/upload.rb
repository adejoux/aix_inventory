class Upload < ActiveRecord::Base
  attr_accessible :upload, :import_type
  has_attached_file :upload
  
  TYPES = %w[server san sod]
end
