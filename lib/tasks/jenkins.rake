#require 'spec/rake/spectask'
require 'ci/reporter/rake/rspec' 

desc 'Jenkins testing task'
Spec::Rake::SpecTask.new(:jenkins => ["ci:setup:rspec"]) do |t|
  t.spec_opts = ['--color']
end



