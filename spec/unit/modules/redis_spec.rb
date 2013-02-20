require 'spec_helper'

describe Vagrant::Boxen::Modules::Redis do
  let(:manifest) { subject.build_manifest }

  it 'includes redis class on manifest' do
    manifest.should == 'include redis'
  end
end
