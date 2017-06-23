require 'spec_helper'

describe 'ucarp', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts)  { facts }
      let(:params) { { :virtual_id => '001', :virtual_ip => '192.168.0.1', :virtual_if => 'eth0', :virtual_pw => 'SuperHyperSecret', :script_up_template => 'ucarp/scripts/vip-up.erb', :script_down_template => 'ucarp/scripts/vip-down.erb' } }

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('ucarp::package') }
      it { is_expected.to contain_class('ucarp::config') }
      it { is_expected.to contain_class('ucarp::service') }
      it { is_expected.to contain_class('ucarp::params') }
      it { is_expected.to contain_class('ucarp::scripts') }

      it { is_expected.to contain_package('ucarp').with_ensure('installed') }

      it { is_expected.to contain_file('/etc/ucarp').with_ensure('directory') }
      it { is_expected.to contain_file('/etc/ucarp/vip-common.conf').with_ensure('file') }
      it { is_expected.to contain_file('/etc/ucarp/vip-001.conf').with_ensure('file') }
      it { is_expected.to contain_file('/usr/libexec/ucarp/vip-down').with_ensure('file') }
      it { is_expected.to contain_file('/usr/libexec/ucarp/vip-up').with_ensure('file') }

      it 'should generate valid content for vip-common.conf' do
        content = catalogue.resource('file', '/etc/ucarp/vip-common.conf').send(:parameters)[:content]
        expect(content).to match('PASSWORD="SuperHyperSecret"')
        expect(content).to match('BIND_INTERFACE="eth0"')
      end

      it 'should generate valid content for vip-001.conf' do
        content = catalogue.resource('file', '/etc/ucarp/vip-001.conf').send(:parameters)[:content]
        expect(content).to match('VIP_ADDRESS="192.168.0.1"')
      end

      case facts[:osfamily]
      when 'RedHat'
        case facts[:operatingsystemmajrelease]
        when '7'
          it { is_expected.to contain_service('ucarp@001').with( 'ensure' => 'running', 'enable' => 'true') }
        else
          it { is_expected.to contain_service('ucarp').with( 'ensure' => 'running', 'enable' => 'true') }
        end
      else
        it { is_expected.to contain_warning('The current operating system is not supported!') }
      end
    end
  end
end
