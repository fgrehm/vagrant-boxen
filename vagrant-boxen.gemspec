# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-boxen/version'

Gem::Specification.new do |gem|
  gem.name          = "vagrant-boxen"
  gem.version       = Vagrant::Boxen::VERSION
  gem.authors       = ["Fabio Rehm"]
  gem.email         = ["fgrehm@gmail.com"]
  gem.description   = %q{Easier vagrant development boxes creation}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/fgrehm/vagrant-boxen"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'vagrant'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rspec-spies'
  gem.add_development_dependency 'rspec-fire'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'librarian-puppet'
end
