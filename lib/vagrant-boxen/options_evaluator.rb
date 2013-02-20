module Vagrant::Boxen
  # TODO: Write specs ;)
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
