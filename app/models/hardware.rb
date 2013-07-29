class Hardware < ActiveRecord::Base
  attr_accessible :firmware, :serial, :server_id, :sys_model

  has_many :servers

  validates_presence_of :firmware, :serial, :server_id, :sys_model
  validates :sys_model, :format => { :with => /-/, :message => "should be like TTTT-MMM"}

  def customer_scope(customer)
    unless customer.empty?
      where("servers.customer = ?", customer)
    else
      scoped
    end
  end
end
