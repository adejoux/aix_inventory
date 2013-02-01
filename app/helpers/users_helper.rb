# -*- encoding : utf-8 -*-
module UsersHelper
  def display_date(date)
    unless date.nil?
      date.to_formatted_s(:short)
    end
  end
end
