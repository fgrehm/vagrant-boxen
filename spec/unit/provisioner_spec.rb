require 'spec_helper'

describe Vagrant::Boxen::Provisioner do
  let(:uuid)                  { 'box-uuid' }
  let(:config)                { described_class::Config.new }
  let(:puppet_manifests_path) { "/tmp/vagrant-boxen-#{uuid}" }
  let(:puppet_module_path)    { File.join(File.expand_path('../../../', __FILE__), 'puppet-modules') }

  before do
    @app, @env = action_env(vagrant_env.vms.values.first.env)
    @env['vm'].stub(:uuid => uuid)
  end

  subject { described_class.new(@env, config) }

  describe 'inner puppet provisioner configuration' do
    # REFACTOR: This is way too much coupling
    let(:puppet_config) { subject.instance_variable_get(:@puppet_provisioner).config }

    it 'sets module path to vendored puppet modules' do
      puppet_config.module_path.should == puppet_module_path
    end

    it 'sets the manifest path to the tmp folder' do
      puppet_config.manifests_path.should == puppet_manifests_path
    end
  end

  describe 'provisioner flow' do
    let(:puppet)  { fire_double('Vagrant::Provisioners::Puppet', :prepare => true, :provision! => true) }
    let(:builder) { fire_double('Vagrant::Boxen::ManifestBuilder', :build => 'PUPPET MANIFEST!') }

    subject { described_class.new(@env, config, puppet) }

    context 'preparation' do
      before do
        Vagrant::Boxen::ManifestBuilder.stub(:new => builder)
        subject.prepare
      end

      it 'generates box manifest using the builder' do
        File.read("#{puppet_manifests_path}/site.pp").should == 'PUPPET MANIFEST!'
      end

      it 'delegates to puppet provisioner' do
        puppet.should have_received(:prepare)
      end
    end

    context 'provisioning' do
      before { subject.provision! }

      it 'delegates to puppet provisioner' do
        puppet.should have_received(:provision!)
      end
    end
  end
end
