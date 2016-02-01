module ActivityPermissionEngine
  module ActivityPermissionsRegistry
    module Interface

      # @param [String] activity_ref
      # @return [Boolean] true if added or false
      def add(activity_ref)
        raise NotImplementedError
      end

      # @return [Array(ActivityPermission)]
      def all
        get_all_activities.map { |activity| ActivityPermission.new(activity[:activity_ref], activity[:role_refs])}
      end

      # @param [String] activity_ref
      # @return [Boolean] true if deleted or false
      def del(activity_ref)
        raise NotImplementedError
      end

      # @param [String] activity_ref
      # @param [Array(String)] role_ref
      # @return [Boolean] true if added or false
      def add_role(activity_ref, role_ref)
        raise NotImplementedError
      end

      # @param [String] activity_ref
      # @return [ActivityPermission] the found activity or false
      def find_by_activity_ref(activity_ref)
        activity = get_activity_by_ref(activity_ref)
        activity && ActivityPermission.new(activity[:activity_ref], activity[:role_refs])
      end

      private

      # @return [Array(Hash)]
      def get_all_activities
        raise NotImplementedError
      end

      def get_activity_by_ref(activity_ref)
        raise NotImplementedError
      end
    end

    class ActivityPermission
      def initialize(activity_ref, role_refs)
        @activity_ref = activity_ref
        @role_refs = role_refs
      end

      attr_reader(:activity_ref, :role_refs)
    end
  end
end
