class Report < ActiveRecord::Base
  attr_accessible :name, :description, :report_type, :os_type, :report_fields_attributes, :selected_fields
  has_many :report_fields
  accepts_nested_attributes_for :report_fields

  validates_presence_of :name

  TYPES = %w[server san]
  FIELD_TYPES = %w[server_attribute server san_infra hardware lparstat]

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

  def make_request
    case report_type
      when "server"
        Server.includes(:operating_system_type)
              .includes(:operating_system)
              .includes(:customer)
      when "san"
        Wwpn.includes(:san_infra)
            .includes(:linux_port)
            .includes(:aix_port)
            .includes(:server)
    end
  end

end
