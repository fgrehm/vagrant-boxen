module Vagrant::Boxen::Modules
  class Redis
    module Config
      def redis(options = nil, &options_block)
        enable_module Redis.new(options, &options_block)
      end
    end

    def initialize(options = nil, &options_block)
      options = eval_options([:memory, :port], &options_block) if !options && options_block
      @options = {
        :redis_max_memory => options.fetch(:memory, '5mb'),
        :redis_port       => options[:port]
      }
    end

    def build_manifest
      "class { 'redis': #{puppet_options}}"
    end

    private

    def eval_options(allowed_options, &block)
      OptionsEvaluator.new(allowed_options, &block).to_hash
    end

    def puppet_options
      beggining = @options.size > 1 ? "\n" : ''
      beggining + @options.map do |key, value|
        "  #{key} => '#{value}',\n" if value
      end.compact.join
    end

    class OptionsEvaluator
      def initialize(allowed_options, &block)
        @allowed_options = allowed_options
        @block           = block
        @hash            = {}
      end

      def method_missing(method, *args)
        if @allowed_options.include?(method)
          @hash[method] = args.first
        else
          super
        end
      end

      def to_hash
        instance_eval(&@block)
        @hash
      end
    end
  end
end

Vagrant::Boxen::Provisioner.config_class.instance_eval do
  include Vagrant::Boxen::Modules::Redis::Config
end
