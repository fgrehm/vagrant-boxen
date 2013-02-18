require "bundler/gem_tasks"

task :update do
  require 'fileutils'
  sh 'librarian-puppet install --path="puppet/modules" --strip-dot-git --clean --verbose'
  Dir['./puppet/modules/*/{.git,.gitignore,tests,spec,Rakefile,.travis.yml}'].each do |path|
    FileUtils.rm_rf path
  end
end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)

  desc 'Run specs with code coverage enabled'
  task :coverage do
    ENV['COVERAGE'] = 'true'
    Rake::Task["spec"].execute
  end

  task :default => :coverage

  task :ci => :spec
rescue LoadError; end
