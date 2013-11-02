# == Schema Information
#
# Table name: report_customers
#
#  id          :integer          not null, primary key
#  report_id   :integer
#  customer_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ReportCustomer < ActiveRecord::Base
  belongs_to :report
  belongs_to :customer
  # attr_accessible :title, :body
end
