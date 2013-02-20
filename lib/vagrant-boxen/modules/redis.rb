module Vagrant::Boxen::Modules
  class Redis
    module Config
      def redis!
        enable_module(Redis.new)
      end
    end

    def initialize(options)
      @options = {
        :redis_max_memory => options.fetch(:memory, '5mb'),
        :redis_port       => options[:port]
      }
    end

    def build_manifest
      "class { 'redis': #{puppet_options}}"
    end

    private

    def puppet_options
      beggining = @options.size > 1 ? "\n" : ''
      beggining + @options.map do |key, value|
        "  #{key} => '#{value}',\n" if value
      end.compact.join
    end
  end
end

Vagrant::Boxen::Provisioner.config_class.instance_eval do
  include Vagrant::Boxen::Modules::Redis::Config
end
