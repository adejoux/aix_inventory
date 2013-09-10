class ServerAttribute < ActiveRecord::Base
  attr_accessible :category, :conf_errors, :description, :name, :output, :return_code, :server_id
  belongs_to :server
  has_paper_trail :only => [:name, :description, :category, :conf_errors, :output, :return_code]


end
