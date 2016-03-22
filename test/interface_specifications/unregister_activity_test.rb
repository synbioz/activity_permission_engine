require_relative '../test_helper'

module ActivityPermissionEngine
  describe 'ActivityPermissionEngine.unregister_activity(activity_ref)' do
    let(:activity_ref) { 'foo' }
    let(:succeed) { true }
    let(:activity_permissions_registry) { Minitest::Mock.new.expect(:del, succeed, [activity_ref]) }

    subject { ActivityPermissionEngine.unregister_activity(activity_ref) }

    before(:each) do
      ActivityPermissionEngine.configuration.activity_permissions_registry = activity_permissions_registry
    end

    it 'returns UnregisterActivity::Response' do
      subject.must_be_kind_of UnregisterActivity::Response
    end

    describe 'when succeed' do
      describe 'UnregisterActivity::Response#success?' do
        it 'returns true' do
          subject.success?.must_equal true
        end
      end
    end

    describe 'when fail' do
      let(:succeed) { false }
      describe 'UnregisterActivity::Response#success?' do
        it 'returns false' do
          subject.success?.must_equal false
        end
      end
    end

    describe 'UnregisterActivity::Request#new(activity_ref)' do
      it 'require activity_ref string as parameter' do
        -> { UnregisterActivity::Request.new }.must_raise ArgumentError
      end
    end
  end
end
