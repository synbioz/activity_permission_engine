require_relative '../test_helper'

module ActivityPermissionEngine
  describe 'ActivityPermissionEngine.list_activities' do
    let(:activity_refs) { ['foo', 'bar'] }
    subject { ActivityPermissionEngine.list_activities }

    before(:each) do
      ActivityPermissionEngine.configuration = Configuration.new(activities: activity_refs)
    end

    it 'returns ListActivities::Response' do
      subject.must_be_kind_of ListActivities::Response
    end

    describe 'ListActivities::Response#activity_refs' do
      subject { ActivityPermissionEngine.list_activities.activity_refs }
      it 'returns Array(activity_ref)' do
        subject.must_equal activity_refs
      end
    end
  end
end

