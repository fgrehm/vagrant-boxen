require 'spec_helper'

describe Vagrant::Boxen::Modules::Memcached do
  let(:manifest) { subject.build_manifest }

  subject { described_class.new(:memory => '10%') }

  it 'includes memcached class on manifest' do
    manifest.should =~ /^class { 'memcached': /
  end

  it 'maps memory option to max_memory' do
    manifest.should =~ /max_memory\s+=>\s+'10%',/
  end
end
