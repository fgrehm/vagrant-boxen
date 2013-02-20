require 'spec_helper'

describe Vagrant::Boxen::Modules::Redis do
  let(:manifest) { subject.build_manifest }

  subject { described_class.new(:memory => '1gb') }

  it 'includes redis class on manifest' do
    manifest.should =~ /^class { 'redis': /
  end

  it 'maps memory option to redis_max_memory' do
    manifest.should =~ /redis_max_memory\s+=>\s+'1gb'/
  end
end
