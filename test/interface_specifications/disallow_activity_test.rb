require_relative '../test_helper'

module ActivityPermissionEngine
  describe 'ActivityPermissionEngine.disallow_activity(disallow_activity_request)' do
    let(:activity_ref) { 'activity_ref' }
    let(:role_ref) { 'role_ref' }
    let(:request) { DisallowActivity::Request.new(activity_ref, role_ref) }
    let(:activity_permissions_registry) { Minitest::Mock.new.expect(:remove_role,true, [activity_ref, role_ref]) }

    subject { ActivityPermissionEngine.disallow_activity(request) }

    before(:each) do
      ActivityPermissionEngine.configuration.activity_permissions_registry = activity_permissions_registry
    end

    describe 'it require a DisallowActivity::Request as parameter' do
      describe 'DisallowActivity::Request#new(activity_ref, role_ref)' do
        it 'require an activity_ref and role string' do
          -> { DisallowActivity::Request.new('') }.must_raise ArgumentError
        end
      end
    end

    it 'returns DisallowActivity::Response' do
      subject.must_be_kind_of DisallowActivity::Response
    end

    describe 'when succeed' do
      describe 'DisallowActivity::Response#success?' do
        it 'returns true' do
          subject.success?.must_equal true
        end
      end
    end
  end
end