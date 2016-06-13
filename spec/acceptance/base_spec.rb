require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'apache class' do

  context 'basic setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'audit':
      }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe file($generalconf) do
      it { should be_file }
      its(:content) { should match 'puppet managed file' }
      its(:content) { should match '-D' }
      its(:content) { should match '-b 320' }
    end

  end

end
