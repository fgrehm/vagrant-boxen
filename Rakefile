require "bundler/gem_tasks"

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)

  desc 'Run specs with code coverage enabled'
  task :coverage do
    ENV['COVERAGE'] = 'true'
    Rake::Task["spec"].execute
  end

  task :default => :coverage
rescue LoadError; end
