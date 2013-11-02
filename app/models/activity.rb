# == Schema Information
#
# Table name: activities
#
#  id             :integer          not null, primary key
#  action         :string(255)
#  trackable_id   :integer
#  trackable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Activity < ActiveRecord::Base
  attr_accessible :action, :trackable
  belongs_to :trackable, polymorphic: true

  def self.not_updated_since(date)
    where('updated_at <= ?', date)
  end
end
