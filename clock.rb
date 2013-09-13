require "./config/boot"
require "./config/environment"

require "clockwork"
include Clockwork

every 1.minutes, 'Hc import worker' do
  puts "Will import now"
  XmlServerImportWorker.perform_async
  CsvServerImportWorker.perform_async
  HcImportWorker.perform_async
end
