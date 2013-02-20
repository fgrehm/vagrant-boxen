require 'vagrant-boxen/base_module'

module Vagrant::Boxen::Modules
  class Redis
    module Config
      def redis(options = nil, &options_block)
        enable_module Redis.new(options, &options_block)
      end
    end

    include Vagrant::Boxen::BaseModule

    def initialize(options = nil, &options_block)
      options = build_options([:memory, :port], options, &options_block)
      @options = {
        :redis_max_memory => options.fetch(:memory, '5mb'),
        :redis_port       => options[:port]
      }
    end

    def build_manifest
      "class { 'redis': #{puppet_options}}"
    end
  end
end

Vagrant::Boxen::Provisioner.config_class.instance_eval do
  include Vagrant::Boxen::Modules::Redis::Config
end
