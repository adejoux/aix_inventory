class ReportOperatingSystemType < ActiveRecord::Base
  belongs_to :report
  belongs_to :operating_system_type
  # attr_accessible :title, :body
end
