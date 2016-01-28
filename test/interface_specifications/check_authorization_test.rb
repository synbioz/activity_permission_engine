require_relative '../test_helper'

describe 'ActivityPermissionEngine.check_authorization(check_authorization_request)' do
  describe 'it require a  CheckAuthorization::Request as parameter' do
    describe 'CheckAuthorization::Request.new(activity_ref,role_ref)' do
      it 'require an activity_ref string' do
        skip 'pending'
      end

      it 'require a role_ref string' do
        skip 'pending'
      end
    end
  end

  it 'return CheckAuthorization::Response' do
    skip 'pending'
  end

  describe 'CheckAuthorization::Response#authorized?' do
    it 'returns false' do
      skip 'pending'
    end
  end

  describe 'when activity is permitted to role' do
    describe 'CheckAuthorization::Response#authorized?' do
      it 'returns true' do
        skip 'pending'
      end
    end
  end
end
