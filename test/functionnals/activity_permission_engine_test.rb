require_relative '../test_helper'

describe 'configured with a registry and a list of activities' do
  let(:provided_activities) { %w(allow_role disallow_role) }

  before(:each) do
    ActivityPermissionEngine.configuration = ActivityPermissionEngine::Configuration.new(activities: provided_activities)
  end

  describe 'I can list activities' do
    subject { ActivityPermissionEngine.list_activities }

    it 'return activity references list' do
      subject.activity_refs.must_equal provided_activities
    end

    describe 'when i add activity at runtime' do
      let(:new_activity) { 'new_activity' }

      before(:each) do
        ActivityPermissionEngine.register_activity(new_activity)
      end
      it 'return the added activity' do
        subject.activity_refs.must_include new_activity
      end
    end
  end

  describe 'When I allow an entity ( like role ) to perform an activity' do
    let(:my_role) { 'roles manager' }
    let(:activity) { 'allow_role' }
    let(:allow_activity_request) { ActivityPermissionEngine::AllowActivity::Request.new(activity, my_role) }

    before(:each) { ActivityPermissionEngine.allow_activity(activity, my_role) }

    describe 'checking for authorization' do
      it 'allows the role to perform activity' do
        ActivityPermissionEngine.check_authorization(activity, [my_role]).authorized?.must_equal true
      end

      describe 'the permission list' do
        subject { ActivityPermissionEngine.list_activities_permissions.activities_permissions }
        it 'includes the new permission' do
          subject.select do
          |ap|
            ap.activity_ref == activity
          end.first.role_refs.must_include my_role
        end
      end


      describe 'I can disallow an entity to perform activity' do
        let(:my_role) { 'roles manager' }
        let(:activity) { 'allow_role' }
        let(:disallow_activity_request) { ActivityPermissionEngine::DisallowActivity::Request.new(activity, [my_role]) }
        let(:check_authorization_request) { ActivityPermissionEngine::CheckAuthorization::Request.new(activity, [my_role]) }

        before(:each) do
          ActivityPermissionEngine.configuration = ActivityPermissionEngine::Configuration.new(
              activity_permission_registry: ActivityPermissionEngine::Adapters::ActivityPermissionsRegistry::Memory.new(
                  {activity => [my_role]}
              )
          )
        end

        it 'disallow the role to perform activity' do
          ActivityPermissionEngine.disallow_activity(my_role, activity)
          ActivityPermissionEngine.check_authorization(activity, [my_role]).authorized?.must_equal false
        end
      end
    end
  end
end

