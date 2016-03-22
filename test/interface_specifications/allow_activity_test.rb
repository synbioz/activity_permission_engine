require_relative '../test_helper'

module ActivityPermissionEngine
  describe 'ActivityPermissionEngine.allow_activity(activity_ref, role_ref)' do
    let(:succeed) { true }
    let(:activity_ref) { 'foo' }
    let(:role_ref) { 'bar' }
    let(:activity_permissions_registry) { Minitest::Mock.new.expect(:add_role, succeed, [activity_ref, role_ref]) }

    before(:each) do
      ActivityPermissionEngine.configuration.activity_permissions_registry = activity_permissions_registry
    end

    subject { ActivityPermissionEngine.allow_activity(activity_ref, role_ref) }

    it 'returns AllowActivity::Response' do
      subject.must_be_kind_of AllowActivity::Response
    end

    describe 'when succeed' do
      describe 'AllowActivity::Response#success?' do
        it 'returns true' do
          subject.success?.must_equal true
        end
      end
    end

    describe 'AllowActivity::Request#new(activity_ref, role_ref)' do
      it 'require activity_ref, role_ref as string' do
        -> { AllowActivity::Request.new('') }.must_raise ArgumentError
      end
    end

  end
end
