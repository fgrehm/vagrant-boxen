module Vagrant
  module Boxen
    class Provisioner < Vagrant::Provisioners::Base
      class Config < Vagrant::Config::Base
        def memcached!
          puts 'Will install memcached with defaults'
          @memcached = true
        end

        def memcached?
          @memcached
        end
      end

      def self.config_class
        Config
      end

      def initialize(env, config)
        super
        @logger = Log4r::Logger.new("vagrant::provisioners::boxen")
        create_manifests_path
        setup_puppet_provisioner
      end

      def prepare
        dir = "/tmp/vagrant-boxen-#{env['vm'].uuid}"
        File.open("#{dir}/site.pp", 'w') { |f| f.puts "package { 'memcached': ensure => 'latest' }" } if config.memcached?
        @puppet_provisioner.prepare
      end

      def provision!
        @puppet_provisioner.provision!
      end

      private

      def create_manifests_path
        dir = "/tmp/vagrant-boxen-#{env['vm'].uuid}"
        Dir.mkdir dir unless Dir.exists? dir
      end

      def setup_puppet_provisioner
        config = Vagrant::Provisioners::Puppet::Config.new
        dir = "/tmp/vagrant-boxen-#{env['vm'].uuid}"
        config.manifests_path = dir
        config.manifest_file  = "site.pp"
        # The root path to be used on the guest machine
        config.pp_path        = '/tmp/vagrant-boxen-puppet'
        config.module_path    = File.join(File.expand_path('../../../', __FILE__), 'puppet/modules')
        config.options << [ '--verbose' ]
        config.options << ['--debug '] if ENV['DEBUG'] == '1'
        @puppet_provisioner = Vagrant::Provisioners::Puppet.new(env, config)
      end
    end
  end
end
