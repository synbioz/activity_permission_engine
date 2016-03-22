module ActivityPermissionEngine
  class CheckAuthorization
    def initialize(request, activities_registry = ActivityPermissionEngine.configuration.activity_permissions_registry)
      @request = request
      @activities_registry = activities_registry
    end

    def call
      Response.new(authorized?)
    end

    private
    attr_reader(:request, :activities_registry)

    def activity
      @activity ||= activities_registry.find_by_activity_ref(request.activity_ref)
    end

    def authorized?
      activity && (activity.role_refs & request.role_refs).length > 0
    end

    class Request
      include Framework::Request

      def initialize(activity_ref, role_refs)
        @activity_ref = activity_ref
        @role_refs = role_refs
      end

      attr_reader(:activity_ref, :role_refs)
    end

    class Response
      def initialize(authorized)
        @authorized = authorized
      end

      def authorized?
        authorized
      end

      attr_reader(:authorized)
    end

  end
end