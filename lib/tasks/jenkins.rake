#require 'spec/rake/spectask'

desc 'install of bundle'
task :install do
  puts "bundle gems will be installed"
  sh 'bundle install'
end

desc 'Jenkins testing task'
Spec::Rake::SpecTask.new(:jenkins => :install) do |t|
  t.spec_opts = ['--color']
end



