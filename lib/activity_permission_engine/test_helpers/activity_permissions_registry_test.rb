module ActivityPermissionEngine
  module TestHelpers
    # Include this module in your adapter's test
    # it will ensure that it quacks like a duck
    module ActivityPermissionsRegistryTest
      def self.included(base)
        base.class_eval do
          it 'respond_to add' do
            subject.must_respond_to(:add)
          end

          it 'respond_to all' do
            subject.must_respond_to(:all)
          end

          it 'respond_to del' do
            subject.must_respond_to(:del)
          end

          it 'respond_to add_role' do
            subject.must_respond_to(:add_role)
          end

          it 'respond_to find_by_activity_ref' do
            subject.must_respond_to(:find_by_activity_ref)
          end
        end
      end
    end
  end
end