class Report < ActiveRecord::Base
  attr_accessible :name, :description, :report_type, :report_fields_attributes
  has_many :report_fields
  accepts_nested_attributes_for :report_fields

  validates_presence_of :name

  TYPES = %w[server_attribute wwpn ]
end
