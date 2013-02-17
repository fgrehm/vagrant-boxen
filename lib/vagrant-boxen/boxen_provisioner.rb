module Vagrant
  class BoxenProvisioner < Vagrant::Provisioners::Base
    class Config < Vagrant::Config::Base
      def memcached!
        puts 'Will install memcached with defaults'
      end
    end

    def self.config_class
      Config
    end

    def initialize(env, config)
      super
      @logger = Log4r::Logger.new("vagrant::provisioners::boxen")
    end

    def prepare
      puts 'Preparing provisioner...'
    end

    def provision!
      puts 'Provisioning...'
    end
  end
end
