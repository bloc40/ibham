require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :rspec

RSpec::Core::RakeTask.new(:rspec) do |test|
  test.rspec_opts = ['--color']
  test.pattern = './spec/**/*_spec.rb'
end
