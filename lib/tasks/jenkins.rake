#require 'spec/rake/spectask'
require 'ci/reporter/rake/rspec' 

desc 'Jenkins testing task'
Spec::Rake::SpecTask.new(:jenkins => ["ci:setup:rspec"]) do |t|
  Rails.env = "test"
  Rake::Task["db:drop"].invoke
  Rake::Task["db:setup"].invoke
  t.spec_opts = ['--color']
end



