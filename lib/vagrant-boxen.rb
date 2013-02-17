require 'vagrant'

if File.exists?(File.join(File.expand_path('../../', __FILE__), '.git'))
  $:.unshift(File.expand_path('../../lib', __FILE__))
end

require "vagrant-boxen/version"
require "vagrant-boxen/boxen_provisioner"

module Vagrant
  module Boxen
  end
end
