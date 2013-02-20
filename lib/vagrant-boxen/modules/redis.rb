module Vagrant::Boxen::Modules
  class Redis
    module Config
      def redis!
        enable_module(Redis.new)
      end
    end

    def initialize(options)
      @options = options.slice(:memory)
    end

    def build_manifest
      extra = @options.key?(:memory) ?
        "redis_max_memory => '#{@options[:memory]}'" :
        ''

      "class { 'redis': \n#{extra}}"
    end
  end
end

Vagrant::Boxen::Provisioner.config_class.instance_eval do
  include Vagrant::Boxen::Modules::Redis::Config
end
