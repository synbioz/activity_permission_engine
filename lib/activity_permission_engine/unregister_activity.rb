module ActivityPermissionEngine
  class UnregisterActivity
    def initialize(request, activities_registry = ActivityPermissionEngine.configuration.activity_permissions_registry)
      @request = request
      @activities_registry = activities_registry
    end

    def call
      Response.new(activities_registry.del(request.activity_ref))
    end

    private
    attr_reader(:request, :activities_registry)

    class Request
      include Framework::Request

      def initialize(activity_ref)
        @activity_ref = activity_ref
      end

      attr_reader(:activity_ref)
    end

    class Response
      def initialize(success)
        @success = success
      end

      def success?
        success
      end

      private
      attr_reader(:success)
    end
  end
end