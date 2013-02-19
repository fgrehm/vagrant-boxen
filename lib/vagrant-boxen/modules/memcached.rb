module Vagrant::Boxen::Modules
  class Memcached
    module Config
      def memcached!
        enable_module(Memcached.new)
      end
    end

    def build_manifest
      "class { 'memcached': }"
    end
  end
end

Vagrant::Boxen::Provisioner.config_class.instance_eval do
  include Vagrant::Boxen::Modules::Memcached::Config
end
