require 'spec_helper'

describe ApplicationHelper do
  describe 'flash_class' do
    subject { helper.flash_class(flash_key) }
    context 'when flash key is alert' do
      let(:flash_key) { 'alert' }
      it { should == 'alert-warning' }
    end
    context 'when flash key is error' do
      let(:flash_key) { 'error' }
      it { should == 'alert-error' }
    end
  end
end
