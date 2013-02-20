module Vagrant::Boxen::Modules
  class Memcached
    module Config
      def memcached(options = nil, &options_block)
        enable_module Memcached.new(options, &options_block)
      end
    end

    include Vagrant::Boxen::BaseModule

    def initialize(options = nil, &options_block)
      options = build_options([:memory], options, &options_block)
      @options = { :max_memory => options.fetch(:memory, '25') }
    end

    def build_manifest
      "class { 'memcached': #{puppet_options}}"
    end
  end
end

Vagrant::Boxen::Provisioner.config_class.instance_eval do
  include Vagrant::Boxen::Modules::Memcached::Config
end
