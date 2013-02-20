require 'spec_helper'

describe Vagrant::Boxen::ManifestBuilder do
  let(:rbenv)     { mock(:rbenv_module,     :build_manifest => 'RBENV') }
  let(:memcached) { mock(:memcached_module, :build_manifest => 'MEMCACHED') }
  let(:config)    { mock(:config, :enabled_modules => [rbenv, memcached]) }
  let(:manifest)  { subject.build }

  subject { described_class.new(config) }

  it 'builds manifest based on enabled modules' do
    manifest.should =~ /RBENV\s+MEMCACHED/
  end

  it 'adds default path for Exec resource' do
    manifest.split("\n").first.should =~ /^Exec { path => \[ '\/bin\/'/
  end
end
