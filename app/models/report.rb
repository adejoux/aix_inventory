class Report < ActiveRecord::Base
  attr_accessible :name, :description, :report_type, :os_type, :report_fields_attributes, :selected_fields, :operating_system_type_ids, :customer_ids
  has_many :report_fields
  accepts_nested_attributes_for :report_fields
  has_many :report_operating_system_types
  has_many :operating_system_types, :through => :report_operating_system_types
  has_many :report_customers
  has_many :customers, :through => :report_customers
  belongs_to :user
  validates_presence_of :name, :report_type

  TYPES = %w[server san]
  FIELD_TYPES = %w[server_attribute server san_infra hardware lparstat linux_port aix_port]

  def selected_fields
    report_fields
  end

  def selected_fields=(fields)
    report_ids=[]
    fields.split(',').each do |value|
      match_results=value.match(/(\S+)\[(\S+)\]/)
      next if match_results.nil?
      field_type=match_results[1]
      attribute=match_results[2]
      next unless FIELD_TYPES.include? field_type
      report=report_fields.find_or_create_by_select_attribute(association_type: field_type, select_attribute: attribute)
      report_ids << report.id

    end
    #delete ids
    clean_ids=report_field_ids - report_ids
    ReportField.find_all_by_id(clean_ids).each do |field|
      field.destroy
    end

    report_fields
  end
end
