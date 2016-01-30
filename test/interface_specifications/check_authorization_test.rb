require_relative '../test_helper'

module ActivityPermissionEngine
  describe 'ActivityPermissionEngine.check_authorization(check_authorization_request)' do
    let(:activity_ref) { 'activity_ref' }
    let(:user_role_refs) { ['baz','buzz'] }
    let(:role_refs) { ['foo', 'bar'] }
    let(:activities_registry) { Minitest::Mock.new.expect(:find_by_activity_ref, activity, [activity_ref]) }
    let(:request) { CheckAuthorization::Request.new(activity_ref, user_role_refs) }
    let(:activity) { Minitest::Mock.new }

    before(:each) do
      activity.expect(:activity_ref, activity_ref)
      activity.expect(:role_refs, role_refs)
      ActivityPermissionEngine.configuration.activities_registry = activities_registry
    end

    subject { ActivityPermissionEngine.check_authorization(request) }

    describe 'it require a  CheckAuthorization::Request as parameter' do
      describe 'CheckAuthorization::Request.new(activity_ref,role_refs)' do
        it 'require an activity_ref string and role_refs array' do
          lambda { CheckAuthorization::Request.new('') }.must_raise ArgumentError
        end
      end
    end

    it 'return CheckAuthorization::Response' do
      subject.must_be_kind_of CheckAuthorization::Response
    end

    describe 'CheckAuthorization::Response#authorized?' do
      it 'returns false' do
        subject.authorized?.must_equal false
      end
    end

    describe 'when activity is permitted to role' do
      let(:user_role_refs) { ['foo','baz'] }

      describe 'CheckAuthorization::Response#authorized?' do
        it 'returns true' do
          subject.authorized?.must_equal true
        end
      end
    end
  end
end
