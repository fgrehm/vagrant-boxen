require 'spec_helper'

describe Vagrant::Boxen::Modules::Memcached do
  let(:manifest) { subject.build_manifest }

  it 'includes memcached class on manifest' do
    manifest.should == "class { 'memcached': }"
  end
end
