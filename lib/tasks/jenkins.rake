#require 'spec/rake/spectask'
require 'ci/reporter/rake/rspec' 
desc 'install of bundle'
task :install do
  puts "bundle gems will be installed"
  sh 'bundle install'
end

desc 'Jenkins testing task'
Spec::Rake::SpecTask.new(:jenkins => [:install, "ci:setup:rspec"]) do |t|
  t.spec_opts = ['--color']
end



