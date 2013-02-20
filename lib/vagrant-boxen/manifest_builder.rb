module Vagrant
  module Boxen
    class ManifestBuilder
      def initialize(config)
        @config = config
      end

      def build
        exec_defaults + @config.enabled_modules.map do |mod|
          mod.build_manifest
        end.join("\n")
      end

      private

      def exec_defaults
        "Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/'] }\n"
      end
    end
  end
end
