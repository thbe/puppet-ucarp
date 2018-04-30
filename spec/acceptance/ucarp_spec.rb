require 'spec_helper_acceptance'

describe 'ucarp' do
  let(:manifest) {
    <<-CLASSPARAMETER
class { 'ucarp':
  virtual_id           => '001',
  virtual_ip           => '192.168.0.1',
  virtual_if           => 'eth0',
  virtual_pw           => 'SuperHyperSecret',
  script_up_template   => 'ucarp/scripts/vip-up.erb',
  script_down_template => 'ucarp/scripts/vip-down.erb',
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

  describe file('/etc/ucarp') do
    it { should be_directory }
    it { should exist }
  end

  describe file('/etc/ucarp/vip-common.conf') do
    it { should be_file }
    it { should exist }
  end

  describe file('/etc/ucarp/vip-001.conf') do
    it { should be_file }
    it { should exist }
  end

  describe file('/usr/libexec/ucarp/vip-down') do
    it { should be_file }
    it { should exist }
  end

  describe file('/usr/libexec/ucarp/vip-up') do
    it { should be_file }
    it { should exist }
  end

  describe package('ucarp') do
    it { should be_installed }
  end
end
