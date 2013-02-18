require 'rubygems'

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

require 'bundler/setup'

Bundler.require

require 'rspec-spies'

require 'rspec/fire'
RSpec::Fire.configure do |config|
  config.verify_constant_names = true
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.include Vagrant::TestHelpers
  config.include RSpec::Fire
end
