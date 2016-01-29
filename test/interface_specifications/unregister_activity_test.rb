require_relative '../test_helper'

module ActivityPermissionEngine
  describe 'ActivityPermissionEngine.unregister_activity(UnregisterActivity::Request)' do
    let(:activity_ref) { 'foo' }
    let(:succeed) { true }
    let(:activities_registry) { Minitest::Mock.new.expect(:del, succeed, [activity_ref]) }
    let(:request) { UnregisterActivity::Request.new(activity_ref) }

    subject { ActivityPermissionEngine.unregister_activity(request) }

    before(:each) do
      ActivityPermissionEngine.configuration.activities_registry = activities_registry
    end

    describe 'UnregisterActivity::Request#new(activity_ref)' do
      it 'require activity_ref string as parameter' do
        -> { UnregisterActivity::Request.new }.must_raise ArgumentError
      end
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
  end
end
