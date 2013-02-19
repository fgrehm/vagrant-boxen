module Vagrant
  module Boxen
    class ManifestBuilder
      def initialize(config)
        @config = config
      end

      def build
        @config.enabled_modules.map do |mod|
          mod.build_manifest
        end.join("\n")
      end
    end
  end
end
