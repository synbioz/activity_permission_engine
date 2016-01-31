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
  end

  describe 'I can allow an entity ( like role ) to perform an activity' do
    let(:my_role) { 'roles manager' }
    let(:activity) { 'allow_role' }
    let(:allow_activity_request) { ActivityPermissionEngine::AllowActivity::Request.new(activity,my_role) }

    before(:each) { ActivityPermissionEngine.allow_activity(allow_activity_request) }

    it 'allows the role to perform activity' do
      ActivityPermissionEngine.check_authorization(
          ActivityPermissionEngine::CheckAuthorization::Request.new(activity, [my_role])
      ).authorized?.must_equal true
    end
  end

  describe 'I can disallow an entity to perform activity' do
    let(:my_role) { 'roles manager' }
    let(:activity) { 'allow_role' }
    let(:disallow_activity_request) { ActivityPermissionEngine::DisallowActivity::Request.new(activity,[my_role]) }
    let(:check_authorization_request) { ActivityPermissionEngine::CheckAuthorization::Request.new(activity, [my_role])}

    before(:each) do
      ActivityPermissionEngine.configuration = ActivityPermissionEngine::Configuration.new(
        activity_permission_registry: ActivityPermissionEngine::Adapters::ActivityPermissionsRegistry::Memory.new(
          {activity => [my_role]}
        )
      )
    end

    it 'disallow the role to perform activity' do
      ActivityPermissionEngine.disallow_activity(disallow_activity_request)
      ActivityPermissionEngine.check_authorization(check_authorization_request).authorized?.must_equal false
    end
  end
end
