require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'audit class' do

  context 'basic setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'audit':
        add_default_rules => true,
        buffers => '320',
      }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe file('/etc/audit/audit.rules') do
      it { should be_file }
      its(:content) { should match '-D' }
      its(:content) { should match '-b 320' }
      its(:content) { should match '-w /etc/sudoers -p wa -k scope' }
      its(:content) { should match '-w /etc/passwd -p wa -k identity' }
      its(:content) { should match '-w /etc/localtime -p wa -k time-change' }
    end

  end

end
