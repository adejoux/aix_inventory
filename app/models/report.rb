class Report < ActiveRecord::Base
  attr_accessible :name, :description, :report_type, :os_type, :report_fields_attributes, :selected_fields, :operating_system_type_ids, :customer_ids
  has_many :report_fields
  accepts_nested_attributes_for :report_fields
  has_many :report_operating_system_types
  has_many :operating_system_types, :through => :report_operating_system_types
  has_many :report_customers
  has_many :customers, :through => :report_customers
  belongs_to :user
  validates_presence_of :name

  TYPES = %w[server san]
  FIELD_TYPES = %w[server_attribute server san_infra hardware lparstat linux_port aix_port]

  def selected_fields
    report_fields
  end

  def selected_fields=(fields)
    fields.split(',').each do |value|
      match_results=value.match(/(\S+)\[(\S+)\]/)
      next if match_results.nil?
      field_type=match_results[1]
      attribute=match_results[2]
      next unless FIELD_TYPES.include? field_type
      report_fields.build(association_type: field_type, select_attribute: attribute)
    end
    report_fields
  end
end
