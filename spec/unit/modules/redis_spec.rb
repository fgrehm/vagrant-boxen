require 'spec_helper'

describe Vagrant::Boxen::Modules::Redis do
  let(:manifest) { subject.build_manifest }

  subject { described_class.new(:memory => '1gb', :port => '1234') }

  it 'includes redis class on manifest' do
    manifest.should =~ /^class { 'redis': /
  end

  it 'maps memory option to redis_max_memory' do
    manifest.should =~ /redis_max_memory\s+=>\s+'1gb',/
  end

  it 'maps port option to redis_port' do
    manifest.should =~ /redis_port\s+=>\s+'1234',/
  end
end
