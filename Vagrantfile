# -*- mode: ruby -*-
# vi: set ft=ruby :

require './lib/vagrant-boxen'

Vagrant::Config.run do |config|
  config.vm.box     = "quantal64"
  config.vm.box_url = "https://github.com/downloads/roderik/VagrantQuantal64Box/quantal64.box"

  config.vm.provision Vagrant::BoxenProvisioner do |boxen|
    boxen.memcached!
  end
end
