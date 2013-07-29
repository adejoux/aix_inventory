class Hardware < ActiveRecord::Base
  attr_accessible :firmware, :serial, :sys_model

  has_many :servers

  validates_presence_of :firmware, :serial, :sys_model
  validates_uniqueness_of :serial
  validates :sys_model, :format => { :with => /-/, :message => "should be like TTTT-MMM"}

  def self.customer_scope(customer)
    unless customer.empty?
      joins(:servers).where("servers.customer = ?", customer)
    else
      scoped
    end
  end
end
