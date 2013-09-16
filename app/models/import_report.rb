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
