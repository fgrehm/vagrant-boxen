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
    boxen.redis {
      memory '5mb'
      port   '1234'
    }

    boxen.memcached!
  end
end
