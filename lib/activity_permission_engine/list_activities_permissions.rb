module ActivityPermissionEngine
  class ListActivitiesPermissions
    def initialize(request, activity_permissions_registry = ActivityPermissionEngine.configuration.activity_permissions_registry)
      @activity_permissions_registry = activity_permissions_registry
      @request = request
    end


    def call
      Response.new(activity_permissions_registry.all)
    end

    private
    attr_reader(:activity_permissions_registry)

    class Request
      include Framework::Request
    end

    class Response
      def initialize(activities_permissions)
        @activities_permissions = activities_permissions
      end

      attr_reader :activities_permissions
    end
  end
end