# -*- mode: ruby -*-
# vi: set ft=ruby :

require './lib/vagrant-boxen'

Vagrant::Config.run do |config|
  config.vm.box     = "quantal64"
  config.vm.box_url = "https://github.com/downloads/roderik/VagrantQuantal64Box/quantal64.box"

  if defined? VagrantVbguest::Config
    config.vbguest.auto_update = false
    config.vbguest.no_remote   = true
  end

  config.vm.provision Vagrant::Boxen::Provisioner do |boxen|
    # Install modules with defaults (the defaults are listed as examples below):
    #  boxen.install :memcached, :redis

    # or set module parameters:

    boxen.redis {
      memory '5mb'
      port   '6379'
    }

    boxen.memcached { memory '25' }
  end
end
