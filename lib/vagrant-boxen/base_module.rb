module Vagrant::Boxen::BaseModule
  # TODO: Auto include module config on provisioner config class

  protected

  def build_options(allowed_options, options, &options_block)
    if !options && options_block
      eval_options(allowed_options, &options_block)
    else
      options
    end
  end

  def eval_options(allowed_options, &block)
    Vagrant::Boxen::OptionsEvaluator.new(allowed_options, &block).to_hash
  end

  def puppet_options
    beggining = @options.size > 1 ? "\n" : ''
    beggining + @options.map do |key, value|
      "  #{key} => '#{value}',\n" if value
    end.compact.join
  end
end
