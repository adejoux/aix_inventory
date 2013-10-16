class ReportBuilder

  def initialize(report, search_params)
    @report=report
    @search_params=search_params
    @type = "#{report.report_type}_report_builder".camelize.to_sym
  end


  def self.build(report, search_params)
    type = "#{report.report_type}_report_builder".camelize.to_sym
    const_get(type).new(report, search_params)
  end

  def columns
    @report.report_fields.select("select_attribute").map { |rq| rq.select_attribute }
  end

  def report
    @report
  end

  def search_params
    @search_params
  end

  def total_display_records
    search_result.count
  end

  def search_result
    @search_result ||= search.result
  end

  def search
    @search ||= build_search
  end

  def build_search_condition
    search.build_condition
  end

  def build_search
    build_query.search(search_params)
  end

  def columns
    @report.report_fields.select("select_attribute").map { |rq| rq.select_attribute }
  end
end
