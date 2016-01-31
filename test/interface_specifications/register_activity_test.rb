require_relative '../test_helper'

module ActivityPermissionEngine
  describe 'ActivityPermissionEngine.register_activity(RegisterActivity::Request)' do
    let(:activity_ref) { 'activity_ref' }
    let(:request) { RegisterActivity::Request.new(activity_ref) }
    let(:succeed) { true }

    subject { ActivityPermissionEngine.register_activity(request) }

    describe 'RegisterActivity::Request#new(activity_ref)' do
      it 'require activity_ref string as parameter' do
        -> {RegisterActivity::Request.new}.must_raise ArgumentError
      end
    end

    it 'returns RegisterActivity::Response' do
      subject.must_be_kind_of RegisterActivity::Response
    end

    describe 'when registration succeed' do
      describe 'RegisterActivity::Response#success?' do
        it 'returns true' do
          subject.success?.must_equal true
        end
      end
    end

    describe 'when registration fail' do
      describe 'RegisterActivity::Response#success?' do
        it 'returns false' do
          activities_registry = Minitest::Mock.new.expect(:add, false, ['activity_ref'])
          ActivityPermissionEngine.configuration.stub(:activities_registry, activities_registry) do
            subject.success?.must_equal false
          end
        end
      end
    end
  end
end
