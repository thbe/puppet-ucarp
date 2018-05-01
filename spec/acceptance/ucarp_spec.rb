require 'spec_helper_acceptance'

describe 'ucarp' do
  let(:manifest) {
    <<-CLASSPARAMETER
class { 'ucarp':
  virtual_id           => '001',
  virtual_ip           => '192.168.0.1',
  virtual_if           => 'eth0',
  virtual_pw           => 'SuperHyperSecret',
}
CLASSPARAMETER
  }

  it 'should apply without errors' do
    apply_manifest(manifest, :catch_failures => true)
  end

  it 'should apply a second time without changes' do
    @result = apply_manifest(manifest)
    expect(@result.exit_code).to be_zero
  end

  describe file('/etc/ucarp/vip-common.conf') do
    it { should be_file }
    it { should exist }
  end

  describe file('/etc/ucarp/vip-001.conf') do
    it { should be_file }
    it { should exist }
  end

  describe file('/etc/ucarp/vip-001.pwd') do
    it { should be_file }
    it { should exist }
  end

  describe package('ucarp') do
    it { should be_installed }
  end
end
