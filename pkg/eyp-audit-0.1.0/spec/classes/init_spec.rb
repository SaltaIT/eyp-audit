require 'spec_helper'
describe 'audit' do

  context 'with defaults for all parameters' do
    it { should contain_class('audit') }
  end
end
