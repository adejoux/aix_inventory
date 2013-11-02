class ImportJob < TrinidadScheduler.Cron "0 0/5 * * * ?"
  def run
    Delayed::Job.enqueue XmlServerImportWorker.new
    Delayed::Job.enqueue CsvServerImportWorker.new
  end
end
