class Report < ActiveRecord::Base
  attr_accessible :name, :report_queries_attributes
  has_many :report_queries
  accepts_nested_attributes_for :report_queries
end
