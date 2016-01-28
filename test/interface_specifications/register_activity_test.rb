require_relative '../test_helper'

module ActivityPermissionEngine
  describe 'ActivityPermissionEngine.register_activity(RegisterActivity::Request)' do
    let(:activity_ref) { 'activity_ref' }
    let(:request) { RegisterActivity::Request.new(activity_ref) }
    let(:succeed) { true }
    let(:activities_registry) { Minitest::Mock.new.expect(:add, succeed, ['activity_ref']) }

    subject { ActivityPermissionEngine.register_activity(request) }

    before(:each) do
      ActivityPermissionEngine.configuration.activities_registry = activities_registry
    end

    describe 'RegisterActivity::Request#new(activity_ref)' do
      it 'require activity_ref string as parameter' do
        -> {RegisterActivity::Request.new}.must_raise ArgumentError
      end
    end

    it 'send add to activity_registry with activity_ref' do
      subject
      activities_registry.verify
    end

    it 'returns RegisterActivity::Response' do
      subject.must_be_kind_of RegisterActivity::Response
    end

    describe 'when registration succeed' do
      describe 'RegisterActivity::Response#success?' do
        it 'returns true' do
          subject.success?.must_be true
        end
      end
    end

    describe 'when registration fail' do
      let(:succeed) { false }
      describe 'RegisterActivity::Response#success?' do
        it 'returns false' do
          subject.success?.must_be false
        end
      end
    end
  end
end
