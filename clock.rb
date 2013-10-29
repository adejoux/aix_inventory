require "./config/boot"
require "./config/environment"

require "clockwork"
include Clockwork

# every 10.minutes, 'Hc import worker' do
#   puts "Will import now"
#   HcImportWorker.perform_async
#   HcConfImportWorker.perform_async
# end

every 1.days, 'Server import' do
  Delayed::Job.enqueue XmlServerImportWorker.new
  Delayed::Job.enqueue CsvServerImportWorker.new
end

every 10.minutes, 'SAN import' do
  Delayed::Job.enqueue CsvSanImportWorker.new
end
every 1.days, "clean up old data" do
  Delayed::Job.enqueue  CleanDataWorker.new
end

