require_relative '../test_helper'

module ActivityPermissionEngine
  describe 'ActivityPermissionEngine.list_activities_permissions' do
    let(:activity_refs) { ['foo', 'bar'] }
    let(:registry) { Minitest::Mock.new }
    subject { ActivityPermissionEngine.list_activities_permissions }

    before(:each) do
      registry.expect(:all, [])
      ActivityPermissionEngine.configuration = Configuration.new(activity_permissions_registry: registry)
    end

    it 'returns ListActivities::Response' do
      subject.must_be_kind_of ListActivitiesPermissions::Response
    end

    describe 'ListActivities::Response#activities_permissions' do
      subject { ActivityPermissionEngine.list_activities_permissions.activities_permissions }
      it 'returns Array()' do
        subject.must_be_kind_of Array
      end
    end
  end
end

