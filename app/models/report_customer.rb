class ReportCustomer < ActiveRecord::Base
  belongs_to :report
  belongs_to :customer
  # attr_accessible :title, :body
end
