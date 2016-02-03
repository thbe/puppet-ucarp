require 'spec_helper'

describe 'ucarp', :type => :class do

  context 'with defaults for all parameters' do
    it { should contain_class('ucarp') }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:params) {
        {
          :virtual_id           => '001',
          :virtual_ip           => '192.168.0.1',
          :virtual_if           => 'eth0',
          :virtual_pw           => 'SuperHyperSecret',
          :script_up_template   => 'ucarp/scripts/vip-up.erb',
          :script_down_template => 'ucarp/scripts/vip-down.erb'
        }
      }

      it { is_expected.to compile.with_all_deps }

      case facts[:osfamily]
      when 'RedHat'
        it { is_expected.to contain_class('ucarp::package') }
        it { is_expected.to contain_class('ucarp::config') }
        it { is_expected.to contain_class('ucarp::service') }

        it { is_expected.to contain_package('ucarp').with_ensure('installed') }

        it { is_expected.to contain_file('/etc/ucarp/vip-common.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/vip-001.conf').with_ensure('file') }

        it { is_expected.to contain_service('ucarp').with( 'ensure' => 'running', 'enable' => 'true') }

        it 'should generate valid content for vip-common.conf' do
          content = catalogue.resource('file', '/etc/ucarp/vip-common.conf').send(:parameters)[:content]
          expect(content).to match('PASSWORD="SuperHyperSecret"')
          expect(content).to match('BIND_INTERFACE="eth0"')
        end

        it 'should generate valid content for vip-001.conf' do
          content = catalogue.resource('file', '/etc/ucarp/vip-001.conf').send(:parameters)[:content]
          expect(content).to match('VIP_ADDRESS="192.168.0.1"')
        end

      else
        it { is_expected.to contain_warning('The current operating system is not supported!') }
      end
    end
  end
end
