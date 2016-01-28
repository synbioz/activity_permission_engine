require_relative '../test_helper'

module ActivityPermissionEngine
  describe 'ActivityPermissionEngine.list_activities' do
    let(:activity_refs) { ['foo', 'bar'] }
    let(:activity_registry) { Minitest::Mock.new.expect(:all, activity_refs) }
    subject { ActivityPermissionEngine.list_activities }

    it 'send :all to the activity_registry' do
      subject
      activity_registry.verify
    end

    it 'returns ListActivities::Response' do
      subject.must_be_kind_of ListAcitivities::Response
    end

    describe 'ListActivities::Response#activities' do
      subject { ActivityPermissionEngine.list_activities.activities }
      it 'returns Array(activity_ref)' do
        subject.must_equal activity_refs
      end
    end
  end
end