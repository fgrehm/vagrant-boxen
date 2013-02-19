require 'spec_helper'

describe Vagrant::Boxen::ManifestBuilder do
  let(:rbenv)     { mock(:rbenv_module,     :build_manifest => 'RBENV') }
  let(:memcached) { mock(:memcached_module, :build_manifest => 'MEMCACHED') }
  let(:config)    { mock(:config, :enabled_modules => [rbenv, memcached]) }

  subject { described_class.new(config) }

  it 'builds manifest based on enabled modules' do
    subject.build.should == "RBENV\nMEMCACHED"
  end
end
