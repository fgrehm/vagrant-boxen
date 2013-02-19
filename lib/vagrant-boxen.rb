require 'vagrant'

if File.exists?(File.join(File.expand_path('../../', __FILE__), '.git'))
  $:.unshift(File.expand_path('../../lib', __FILE__))
end

Dir[File.dirname(__FILE__) + '/**/*.rb'].each do |file|
  require file
end

module Vagrant
  module Boxen
  end
end
