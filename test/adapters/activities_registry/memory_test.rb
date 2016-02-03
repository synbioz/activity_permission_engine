require_relative '../../test_helper'
require_relative '../../../lib/activity_permission_engine/adapters/activity_permissions_registry/memory'
require_relative '../../../lib/activity_permission_engine/test_helpers/activity_permissions_registry_test'

module ActivityPermissionEngine
  describe Adapters::ActivityPermissionsRegistry::Memory do

    let(:activity_ref) { 'example:activity_ref' }
    let(:role_refs) { %w(foo bar) }
    let(:store) { { activity_ref => role_refs} }
    let(:registry) { Adapters::ActivityPermissionsRegistry::Memory.new(store) }

    describe 'implement the activity permission registry interface' do
      subject { registry }
      include ActivityPermissionEngine::TestHelpers::ActivityPermissionsRegistryTest
    end

    describe '#all' do
      subject{ registry.all }

      it 'returns a list of activities' do
        subject.must_be_kind_of Array
        subject.first.must_be_kind_of ActivityPermissionsRegistry::ActivityPermission
      end
    end

    describe '#find_by_activity_ref' do
      subject { registry.find_by_activity_ref(activity_ref) }
      describe 'using an existing activity_ref' do
        it 'return an Activity' do
          subject.must_be_kind_of ActivityPermissionsRegistry::ActivityPermission
        end

        it 'returns the corresponding Activity' do
          subject.activity_ref.must_equal activity_ref
        end
      end

      describe 'when activity_ref does not exists' do
        let(:store) { {'foo' => []} }

        it 'returns false' do
          subject.must_equal false
        end
      end
    end

    describe '#del' do
      let(:existing_activity) { 'activity' }
      subject { registry.del(activity_ref) }

      it 'remove the activity from registry' do
        subject
        registry.find_by_activity_ref(activity_ref).must_equal false
      end
    end

    describe '#add_role' do
      let(:new_role_ref) { 'new_role_ref' }
      subject { registry.add_role(activity_ref, new_role_ref) }

      it 'add role to the role_refs' do
        subject
        registry.find_by_activity_ref(activity_ref).role_refs.must_include new_role_ref
      end
    end
  end
end