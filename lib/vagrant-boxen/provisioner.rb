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
        @logger        = Log4r::Logger.new("vagrant::provisioners::boxen")
        @manifests_dir = "/tmp/vagrant-boxen-#{env['vm'].uuid}"
        Dir.mkdir @manifests_dir unless Dir.exists? @manifests_dir
        setup_puppet_provisioner
      end

      def prepare
        File.open("#{@manifests_dir}/site.pp", 'w') { |f| f.puts "package { 'memcached': ensure => 'latest' }" } if config.memcached?
        @puppet_provisioner.prepare
      end

      def provision!
        @puppet_provisioner.provision!
      end

      private

      def setup_puppet_provisioner
        config = Vagrant::Provisioners::Puppet::Config.new
        config.manifests_path = @manifests_dir
        config.manifest_file  = "site.pp"
        config.module_path    = File.join(File.expand_path('../../../', __FILE__), 'puppet/modules')
        # The root path to be used on the guest machine, changed to avoid
        # collision with the default path for puppet provisioner
        config.pp_path = '/tmp/vagrant-boxen-puppet'
        config.options << [ '--verbose' ]
        config.options << ['--debug '] if ENV['DEBUG'] == '1'
        @puppet_provisioner = Vagrant::Provisioners::Puppet.new(env, config)
      end
    end
  end
end
