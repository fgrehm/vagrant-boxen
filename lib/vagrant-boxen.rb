require 'vagrant'

if File.exists?(File.join(File.expand_path('../../', __FILE__), '.git'))
  ENV['DEBUG'] = '1'
  $:.unshift(File.expand_path('../../lib', __FILE__))
end

module Vagrant
  module Boxen
    module Modules
    end
  end
end

Dir[File.dirname(__FILE__) + '/**/*.rb'].each do |file|
  require file
end
