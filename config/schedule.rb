# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
set :output, "/SMI_Admin/aix_inventory/log/cron.log"

# Learn more: http://github.com/javan/whenever
every 1.hours do
  runner "XmlServerImportWorker.new.perform"
  runner "CsvServerImportWorker.new.perform"
  runner "CsvSanImportWorker.new.perform"
end

every 1.days do
  runner "CleanDataWorker.new.perform"
end
