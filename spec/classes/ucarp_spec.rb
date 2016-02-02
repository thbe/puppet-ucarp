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
          :virtual_id => '001',
          :virtual_ip => '192.168.0.1',
          :virtual_if => 'eth0',
          :virtual_pw => 'SuperHyperSecret',
          :upscript   => 'mymodule/vip-up.erb',
          :downscript => 'mymodule/vip-down.erb'
        }
      }

      it { is_expected.to compile.with_all_deps }

      case facts[:osfamily]
      when 'RedHat'
        it { is_expected.to contain_class('ucarp::package') }
        it { is_expected.to contain_class('ucarp::config') }
        it { is_expected.to contain_class('ucarp::service') }

        it { is_expected.to contain_package('ucarp-common').with_ensure('installed') }
        it { is_expected.to contain_package('ucarp-filedaemon').with_ensure('installed') }
        #it { is_expected.to contain_package('ucarp-filedaemon-glusterfs-plugin').with_ensure('installed') }
        it { is_expected.to contain_package('ucarp-storage').with_ensure('installed') }
        it { is_expected.to contain_package('ucarp-storage-fifo').with_ensure('installed') }
        it { is_expected.to contain_package('ucarp-storage-glusterfs').with_ensure('installed') }
        it { is_expected.to contain_package('ucarp-storage-tape').with_ensure('installed') }
        it { is_expected.to contain_package('ucarp-director').with_ensure('installed') }
        it { is_expected.to contain_package('ucarp-database-common').with_ensure('installed') }
        it { is_expected.to contain_package('ucarp-database-mysql').with_ensure('installed') }
        it { is_expected.to contain_package('ucarp-database-tools').with_ensure('installed') }
        it { is_expected.to contain_package('ucarp-bconsole').with_ensure('installed') }

        it { is_expected.to contain_file('/etc/yum.repos.d/ucarp.repo').with_ensure('file') }

        it { is_expected.to contain_file('/etc/ucarp/ucarp-fd.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-sd.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/populate_ucarp_schema.sh').with_ensure('file') }

        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d').with_ensure('directory') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/clients').with_ensure('directory') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/jobs').with_ensure('directory') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/catalog.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/client-director.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/console.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/director.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/fileset.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/job-backup-catalog.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/job-director.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/job-restore.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/jobdefs.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/messages.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/pool.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/schedule.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/storage.conf').with_ensure('file') }

        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/clients/client01.example.local.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/jobs/client01.example.local.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/clients/client02.example.local.conf').with_ensure('file') }
        it { is_expected.to contain_file('/etc/ucarp/ucarp-dir.d/jobs/client02.example.local.conf').with_ensure('file') }

        it { is_expected.to contain_file('/etc/ucarp/ucarp-sd.d').with_ensure('directory') }

        it { is_expected.to contain_service('ucarp-fd').with( 'ensure' => 'running', 'enable' => 'true') }
        it { is_expected.to contain_service('ucarp-sd').with( 'ensure' => 'running', 'enable' => 'true') }
        it { is_expected.to contain_service('ucarp-dir').with( 'ensure' => 'running', 'enable' => 'true') }

        it { is_expected.to contain_user('ucarp') }
        it { is_expected.to contain_group('ucarp') }

        it 'should generate valid content for ucarp-fd.conf' do
          content = catalogue.resource('file', '/etc/ucarp/ucarp-fd.conf').send(:parameters)[:content]
          expect(content).to match('client-password-for-ucarp')
          expect(content).to match('monitor-password-for-ucarp')
          expect(content).to match('FDport')
          expect(content).to match('FDAddress')
        end

        it 'should generate valid content for ucarp-sd.conf' do
          content = catalogue.resource('file', '/etc/ucarp/ucarp-sd.conf').send(:parameters)[:content]
          expect(content).to match('storage-password-for-ucarp')
          expect(content).to match('monitor-password-for-ucarp')
          expect(content).to match('SDPort')
          expect(content).to match('SDAddress')
        end

        it 'should generate valid content for ucarp-dir.conf' do
          content = catalogue.resource('file', '/etc/ucarp/ucarp-dir.conf').send(:parameters)[:content]
          expect(content).to match('director.conf')
          expect(content).to match('console.conf')
          expect(content).to match('storage.conf')
          expect(content).to match('catalog.conf')
          expect(content).to match('messages.conf')
          expect(content).to match('pool.conf')
          expect(content).to match('schedule.conf')
          expect(content).to match('fileset.conf')
          expect(content).to match('jobdefs.conf')
          expect(content).to match('/etc/ucarp/ucarp-dir.d/clients')
          expect(content).to match('/etc/ucarp/ucarp-dir.d/jobs')
        end

      else
        it { is_expected.to contain_warning('The current operating system is not supported!') }
      end
    end
  end
end
