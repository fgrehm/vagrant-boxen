module Vagrant::Boxen::Modules
  class Redis
    module Config
      def redis!
        enable_module(Redis.new)
      end
    end

    def build_manifest
      "include redis"
    end
  end
end

Vagrant::Boxen::Provisioner.config_class.instance_eval do
  include Vagrant::Boxen::Modules::Redis::Config
end
