# == Schema Information
#
# Table name: import_reports
#
#  id            :integer          not null, primary key
#  filename      :string(255)
#  result        :string(255)
#  output        :text
#  success_count :integer
#  error_count   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ImportReport < ActiveRecord::Base
  attr_accessible :error_count, :filename, :output, :result, :success_count

  def file_error!(status, message)
      self.output = message
      self.result = status
      save!
  end

  def analyze_result
    if self.success_count == 0
      self.result="ERROR"
    elsif self.error_count > 0
      self.result="PARTIALLY"
    else
      self.result="SUCCESS"
    end
  end
end
