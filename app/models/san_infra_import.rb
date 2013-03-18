class SanInfraImport
  # switch to ActiveModel::Model in Rails 4
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :csv_line

  def initialize(entry)
    @csv_line=entry
  end

  def persisted?
    false
  end

  def csv_line
    @csv_line
  end

  def save
    imported_san_infra.save
  end

  def save!
    imported_san_infra.save!
  end

  def imported_san_infra
    @imported_san_infra ||= load_imported_san_infra
  end

  def san_infra
    @san_infra ||= get_san_infra
  end

  def get_san_infra
    SanInfra.find_by_switch_and_port(csv_line[:switch], csv_line[:port]) || SanInfra.new
  end

  def load_imported_san_infra
    san_infra.infra = csv_line[:infra]
    san_infra.fabric = csv_line[:fabric]
    san_infra.switch = csv_line[:switch]
    san_infra.port = csv_line[:port]
    san_infra.speed = csv_line[:speed]
    san_infra.status = csv_line[:status]
    san_infra.portname = csv_line[:portname]
    san_infra.mode = csv_line[:mode]
    san_infra
  end
end