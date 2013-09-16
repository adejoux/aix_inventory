class Activity < ActiveRecord::Base
  attr_accessible :action, :trackable
  belongs_to :trackable, polymorphic: true

  def self.not_updated_since(date)
    where('updated_at <= ?', date)
  end
end
