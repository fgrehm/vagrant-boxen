# Vagrant::Boxen

[![Build Status](https://travis-ci.org/fgrehm/vagrant-boxen.png)](https://travis-ci.org/fgrehm/vagrant-boxen)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/fgrehm/vagrant-boxen)

Inspired by [Rails Wizard](http://railswizard.org/) and GitHub's
[Boxen](http://boxen.github.com/), this gem attempts to lower the "entry barrier"
of getting a manageable Vagrant machine targetted for development up and
running without the need to learn [Puppet](https://puppetlabs.com/puppet/what-is-puppet/)
or [Chef](http://www.opscode.com/chef/).


## Installation

If you use the gem version of Vagrant, use:

```terminal
$ gem install vagrant-boxen
```

otherwise, use:

```terminal
$ vagrant gem install vagrant-boxen
```


## Usage

Just add a `Vagrant::Boxen::Provisioner` to your Vagrantfile:

```ruby
require 'vagrant-boxen'
Vagrant::Config.run do |config|
  # ... other settings ...
  config.vm.provision Vagrant::Boxen::Provisioner do |boxen|
    # Install redis and memcached with defaults
    boxen.install :redis, :memcached

    # or specify configuration options for the module
    boxen.redis {
      port   '1234'
      memory '1gb'
    }
  end
end
```

For now, please refer to the sample [Vagrantfile](Vagrantfile) on this repo for
the most up to date documentation.

While the modules provided might work on most linux distributions, [I'm developing
against](Vagrantfile) an Ubuntu 12.10 64bits box based on https://github.com/downloads/roderik/VagrantQuantal64Box/quantal64.box

To find out more about the planned functionality, check out the
[project's issues](https://github.com/fgrehm/vagrant-boxen/issues).


## How does it work?

Under the hood, [`Vagrant::Boxen::Provisioner`](https://github.com/fgrehm/vagrant-boxen/blob/master/lib/vagrant-boxen/provisioner.rb)
will generate a puppet manifest based on the configured modules that will get
passed to a [`Vagrant::Provisioners::Puppet`](https://github.com/mitchellh/vagrant/blob/1-0-stable/lib/vagrant/provisioners/puppet.rb)
configured to use the bundled puppet modules.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
