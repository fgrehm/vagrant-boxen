module Vagrant
  module Boxen
    class Provisioner < Vagrant::Provisioners::Base
      class Config < Vagrant::Config::Base
        attr_reader :enabled_modules

        def initialize(*args)
          super
          @enabled_modules = []
        end

        def install(mod)
          enable_module module_for(mod).new
        end

        def enable_module(mod)
          @enabled_modules << mod
        end

        protected

        def module_for(mod)
          Vagrant::Boxen::Modules.const_get classify_string(mod)
        end

        def classify_string(string)
          string.to_s.split('_').map do |word|
            word[0] = word[0].upcase
            word
          end.join
        end
      end

      def self.config_class
        Config
      end

      def initialize(env, config, provisioner = nil)
        super(env, config)
        @manifests_dir      = "/tmp/vagrant-boxen-#{env['vm'].uuid}"
        @puppet_provisioner = provisioner ? provisioner : setup_puppet_provisioner
      end

      def prepare
        Dir.mkdir @manifests_dir unless File.directory? @manifests_dir
        builder = ManifestBuilder.new(config)
        File.open("#{@manifests_dir}/site.pp", 'w') { |f| f.print builder.build }
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
        config.module_path    = File.join(File.expand_path('../../../', __FILE__), 'puppet-modules')
        # The root path to be used on the guest machine, changed to avoid
        # collision with the default path for puppet provisioner
        config.pp_path = '/tmp/vagrant-boxen-puppet'

        config.options << [ '--verbose ' ] if ENV['VERBOSE'] == '1'
        config.options << [ '--debug ']    if ENV['DEBUG'] == '1'

        Vagrant::Provisioners::Puppet.new(env, config)
      end
    end
  end
end
