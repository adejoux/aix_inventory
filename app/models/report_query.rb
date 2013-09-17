class ReportQuery < ActiveRecord::Base
  attr_accessible :association_type, :report_id, :select_attribute
  belongs_to :report
end
