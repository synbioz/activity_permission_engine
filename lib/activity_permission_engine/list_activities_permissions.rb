module ActivityPermissionEngine
  class ListActivitiesPermissions
    def initialize(activity_permissions_registry)
      @activity_permissions_registry = activity_permissions_registry
    end


    def call
      Response.new(activity_permissions_registry.all)
    end

    private
    attr_reader(:activity_permissions_registry)

    class Response
      def initialize(activities_permissions)
        @activities_permissions = activities_permissions
      end

      attr_reader :activities_permissions
    end
  end
end