module Vagrant
  module Boxen
    class ManifestBuilder
      def initialize(config)
        @config = config
      end

      def build
        @config.memcached? ?
          "class { 'memcached': }" :
          ''
      end
    end
  end
end
