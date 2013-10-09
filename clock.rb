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
  XmlServerImportWorker.perform_async
  CsvServerImportWorker.perform_async
end

every 10.minutes, 'SAN import' do
  CsvSanImportWorker.perform_async
end
# every 1.minutes, "clean up old data" do
#   CleanDataWorker.perform_async
# end

